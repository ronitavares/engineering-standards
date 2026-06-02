#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"

echo "== Engineering Standards: seed validation =="

node - "$ROOT" <<'NODE'
const fs = require('fs');
const path = require('path');

const root = path.resolve(process.argv[2] || '.');
const ignored = new Set(['node_modules', 'dist', 'coverage', '.git', '.nx']);
const files = [];

function walk(dir) {
  if (!fs.existsSync(dir)) return;
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    if (ignored.has(entry.name)) continue;
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) walk(full);
    else if (entry.isFile() && full.endsWith('.ts') && /(seed|seeder)/i.test(entry.name)) {
      files.push(full);
    }
  }
}

walk(root);

if (files.length === 0) {
  console.log('INFO: no seed files found.');
  process.exit(0);
}

let errors = 0;

for (const file of files) {
  const relative = path.relative(root, file);
  const text = fs.readFileSync(file, 'utf8');

  if (/CREATE TABLE|ALTER TABLE|DROP TABLE|CREATE INDEX|DROP INDEX/i.test(text)) {
    errors += 1;
    console.error(`ERROR: seed appears to change schema: ${relative}`);
  }

  const hasInsert = /INSERT INTO|\.insert\s*\(/i.test(text);
  const hasLookup = /SELECT [\s\S]* WHERE|findOne|findBy|exists|ON DUPLICATE KEY|upsert|UPDATE [\s\S]* WHERE/i.test(text);
  if (hasInsert && !hasLookup) {
    console.warn(`WARN: seed inserts data but no obvious idempotency lookup was found: ${relative}`);
  }

  if (/DELETE FROM|TRUNCATE|DROP /i.test(text)) {
    console.warn(`WARN: seed contains destructive cleanup; verify environment guard: ${relative}`);
  }
}

if (errors > 0) {
  console.error(`FAILED: ${errors} seed error(s) found.`);
  process.exit(1);
}

console.log('OK: seed structure checks passed.');
NODE
