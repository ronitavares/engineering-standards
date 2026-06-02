#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"
CONTEXTS="${ENGINEERING_STANDARDS_CONTEXTS:-${2:-}}"
PACKAGE_SCOPE="${ENGINEERING_STANDARDS_PACKAGE_SCOPE:-${3:-}}"

echo "== Engineering Standards: boundary validation =="

node - "$ROOT" "$CONTEXTS" "$PACKAGE_SCOPE" <<'NODE'
const fs = require('fs');
const path = require('path');

const root = path.resolve(process.argv[2] || '.');
const configuredContexts = parseList(process.argv[3] || '');
const packageScope = (process.argv[4] || '').replace(/\/$/, '');
const domains = path.join(root, 'domains');
const integrations = path.join(root, 'libs', 'integrations');
const ignored = new Set(['node_modules', 'dist', 'coverage', '.git', '.nx']);
const domainFiles = [];
const integrationFiles = [];

function parseList(value) {
  return value
    .split(',')
    .map((item) => item.trim())
    .filter(Boolean);
}

function escapeRegex(value) {
  return value.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
}

function discoverContexts() {
  if (configuredContexts.length > 0) return configuredContexts;
  if (!fs.existsSync(domains)) return [];
  return fs
    .readdirSync(domains, { withFileTypes: true })
    .filter((entry) => entry.isDirectory() && !ignored.has(entry.name))
    .map((entry) => entry.name);
}

function ownerContext(file) {
  const relative = path.relative(root, file).split(path.sep);
  return relative[0] === 'domains' ? relative[1] : undefined;
}

function importRegex(contexts) {
  if (contexts.length === 0) return null;

  const contextGroup = contexts.map(escapeRegex).join('|');
  const patterns = [`[^'"]*domains/(?:${contextGroup})(?:/|['"])`];

  if (packageScope) {
    patterns.push(`${escapeRegex(packageScope)}/(?:${contextGroup})(?:/|['"])`);
  }

  return new RegExp(`from\\s+['"](?:${patterns.join('|')})`);
}

function walk(dir, target) {
  if (!fs.existsSync(dir)) return;
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    if (ignored.has(entry.name)) continue;
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) walk(full, target);
    else if (entry.isFile() && full.endsWith('.ts')) target.push(full);
  }
}

walk(domains, domainFiles);
walk(integrations, integrationFiles);

const contextNames = discoverContexts();
const boundedContextImportRegex = importRegex(contextNames);

const checks = [
  {
    name: 'direct TypeORM repository usage',
    regex: /extends\s+Repository<|@InjectRepository/,
    files: domainFiles,
  },
  {
    name: '@Transactional() without explicit connectionName',
    regex: /@Transactional\(\)/,
    files: domainFiles,
  },
  {
    name: 'integration provider importing bounded context code',
    regex: boundedContextImportRegex,
    files: integrationFiles,
  },
].filter((check) => check.regex);

let errors = 0;

const crossContextMatches = [];
for (const file of domainFiles) {
  const owner = ownerContext(file);
  const otherContexts = contextNames.filter((context) => context !== owner);
  const regex = importRegex(otherContexts);
  if (!regex) continue;

  const text = fs.readFileSync(file, 'utf8');
  if (regex.test(text)) crossContextMatches.push(path.relative(root, file));
}

if (crossContextMatches.length > 0) {
  errors += 1;
  console.error('ERROR: cross-context imports found:');
  for (const match of crossContextMatches) console.error(`  - ${match}`);
}

for (const check of checks) {
  const matches = [];
  for (const file of check.files) {
    const text = fs.readFileSync(file, 'utf8');
    if (check.regex.test(text)) matches.push(path.relative(root, file));
  }
  if (matches.length > 0) {
    errors += 1;
    console.error(`ERROR: ${check.name} found:`);
    for (const match of matches) console.error(`  - ${match}`);
  }
}

if (errors > 0) {
  console.error(`FAILED: ${errors} boundary violation group(s) found.`);
  process.exit(1);
}

console.log('OK: no boundary violations found.');
NODE
