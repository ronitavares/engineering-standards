#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"

echo "== Engineering Standards: migration validation =="

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
    else if (
      entry.isFile() &&
      full.endsWith('.ts') &&
      entry.name !== 'index.ts' &&
      full.includes(`${path.sep}migrations${path.sep}`)
    ) {
      files.push(full);
    }
  }
}

walk(root);

if (files.length === 0) {
  console.log('INFO: no migration files found.');
  process.exit(0);
}

let errors = 0;

for (const file of files) {
  const relative = path.relative(root, file);
  const text = fs.readFileSync(file, 'utf8');

  if (!/implements\s+MigrationInterface/.test(text)) {
    errors += 1;
    console.error(`ERROR: migration does not implement MigrationInterface: ${relative}`);
  }
  if (!/(public\s+)?async\s+up\s*\(/.test(text)) {
    errors += 1;
    console.error(`ERROR: migration missing up(): ${relative}`);
  }
  if (!/(public\s+)?async\s+down\s*\(/.test(text)) {
    errors += 1;
    console.error(`ERROR: migration missing down(): ${relative}`);
  }
  if (/seed|seeder|INSERT INTO .*(_user|_organization|_role)|password|demo|fixture/i.test(text)) {
    console.warn(`WARN: migration may contain seed/demo data; review manually: ${relative}`);
  }
}

if (errors > 0) {
  console.error(`FAILED: ${errors} migration error(s) found.`);
  process.exit(1);
}

console.log('OK: migration structure checks passed.');
NODE
