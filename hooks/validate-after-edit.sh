#!/usr/bin/env bash
set -euo pipefail

if [ -x "engineering-standards/scripts/validate-boundaries.sh" ]; then
  engineering-standards/scripts/validate-boundaries.sh . >/tmp/engineering-standards-boundaries.log 2>&1 || {
    printf '{"additional_context":"Engineering standards boundary validation failed. Review /tmp/engineering-standards-boundaries.log before finalizing."}\n'
    exit 0
  }
fi

printf '{"additional_context":"Engineering standards lightweight validation completed."}\n'
