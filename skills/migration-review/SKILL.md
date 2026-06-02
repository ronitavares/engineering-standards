---
name: migration-review
description: Review database migrations separately from seed data. Use when creating, reviewing, generating, or auditing migrations and schema changes.
---

# Migration Review

Migrations evolve schema. Seeds populate data. Keep them separate.

## Workflow

1. Identify the owning context/app and database connection.
2. Compare entity/schema change against the migration.
3. Verify naming, timestamp, table prefixes, indexes, constraints, and rollback.
4. Confirm no demo/e2e/reference data is inserted unless the project explicitly treats it as required static schema data.
5. Check that automatic schema sync is not used as a migration substitute.
6. Identify required validation commands.

## Review Checklist

- Migration location matches the owning context.
- `up()` and `down()` are both present when supported.
- Destructive operations are explicit and justified.
- SQL is deterministic and environment-independent.
- No seed runner is invoked.
- No app runtime secrets are needed.
- Migration command is documented.

## Output

Report: status, risks, required fixes, rollback notes, and verification commands.
