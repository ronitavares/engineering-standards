#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"

echo "== Engineering Standards: boundary validation =="

node - "$ROOT" <<'NODE'
const fs = require('fs');
const path = require('path');

const root = path.resolve(process.argv[2] || '.');
const domains = path.join(root, 'domains');
const integrations = path.join(root, 'libs', 'integrations');
const ignored = new Set(['node_modules', 'dist', 'coverage', '.git', '.nx']);
const domainFiles = [];
const integrationFiles = [];

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

const checks = [
  {
    name: 'cross-context imports',
    regex: /from\s+['"]@funbe\/(identity|catalog|sales|ordering)['"]/,
    files: domainFiles,
  },
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
    regex: /from\s+['"](?:.*domains\/|@funbe\/(identity|catalog|sales|ordering))/,
    files: integrationFiles,
  },
];

let errors = 0;

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
