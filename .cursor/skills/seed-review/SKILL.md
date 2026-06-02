---
name: seed-review
description: Review seed scripts separately from migrations. Use when creating, reviewing, auditing, or fixing foundation, demo, journey, or e2e seeds.
---

# Seed Review

Seeds populate or reconcile data. They must be idempotent, environment-aware, and separate from migrations.

## Workflow

1. Classify the seed: foundation/reference, demo, journey, e2e, or cleanup.
2. Identify target environment and required migrations.
3. Verify idempotency keys and duplicate protection.
4. Verify transaction handling for multi-step inserts.
5. Check whether cleanup is safe and environment-gated.
6. Confirm no schema changes are performed.
7. Identify verification commands and expected output.

## Review Checklist

- Running twice does not duplicate data.
- Stable business keys are used for lookups.
- Random IDs do not break idempotency.
- Secrets and credentials are not production values.
- Cleanup is explicit and guarded.
- Seed docs state prerequisites and target environments.

## Output

Report: seed type, idempotency assessment, operational risk, required fixes, and verification commands.
