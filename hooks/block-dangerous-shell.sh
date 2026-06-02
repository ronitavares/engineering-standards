#!/usr/bin/env bash
set -euo pipefail

input="$(cat)"
command="$(printf '%s' "$input" | node -e "let s='';process.stdin.on('data',c=>s+=c).on('end',()=>{try{const j=JSON.parse(s); console.log(j.command || '')}catch{console.log('')}})")"

if printf '%s' "$command" | rg -q "git\s+reset\s+--hard|git\s+push\s+--force|rm\s+-rf\s+/|DROP\s+DATABASE|TRUNCATE\s+TABLE|docker\s+system\s+prune"; then
  printf '%s\n' '{"permission":"deny","user_message":"Command blocked by engineering standards: destructive shell operation.","agent_message":"The shell command matches a dangerous operation policy."}'
  exit 0
fi

printf '%s\n' '{"permission":"allow"}'
