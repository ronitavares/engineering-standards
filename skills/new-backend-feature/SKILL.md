---
name: new-backend-feature
description: Implement a backend feature following bounded context, feature folder, NestJS, persistence, Swagger, and testing standards. Use when creating or modifying backend features.
---

# New Backend Feature

Use the project's existing architecture before adding new abstractions.

## Workflow

1. Identify the owning bounded context and feature.
2. Classify complexity using `feature-complexity.mdc`: simple CRUD, lifecycle feature, cross-context feature, or application workflow that benefits from a use case.
3. Identify tenant scope: global entity or tenant-aware entity.
4. Identify security and privacy needs: auth requirements, permission policy, rate limiting, sensitive data, and audit logging.
5. Identify runtime needs: required config, secrets, feature flags, cache/pagination, background jobs, and performance budget.
6. Identify communication needs:
   - HTTP client for synchronous cross-context queries.
   - Outbox/event for asynchronous side effects with real consumers.
   - State machine only for real lifecycle transitions.
7. Identify whether the feature needs reusable external providers. If yes, place provider implementation in `libs/integrations` and context-specific adaptation in `domains/{context}/src/infrastructure/external`.
8. Read the context README/module and one nearby feature with similar behavior.
9. Create or update code in the feature folder:
   - `core/service`
   - `core/use-case` when the action coordinates multiple dependencies, writes, external calls, or domain rules
   - `http/rest/controller`
   - `http/rest/dto`
   - `persistence/entity`
   - `persistence/repository`
10. Register providers in the single context module, persistence module, integration module, or app module according to local pattern.
11. Add Swagger decorators and response DTO mapping.
12. Use structured exceptions with `{ message, context }`.
13. If schema changes are needed, create a migration. Do not add seed data to the migration.
14. If data setup is needed, create or update a seed separately.
15. Add focused tests based on risk, including contract tests when cross-context/public contracts change.
16. Update relevant docs when behavior, patterns, or decisions changed.
17. Run the smallest relevant validation commands.

## Guardrails

- Controllers do not inject repositories.
- Controllers may call a use case for non-trivial workflows; simple CRUD may call a service directly.
- Contexts do not import other contexts directly.
- Writes use explicit transactions when required by the project.
- Entities and repositories stay owned by the feature.
- Shared code is infrastructure or generic utility, not feature business logic.
- Reusable external providers stay in `libs/integrations`.
- Context business decisions stay in `domains/{context}`.
- Avoid architecture anti-patterns listed in `architecture-anti-patterns.mdc`.
- Apply security, configuration, privacy, cache/performance, jobs, and CI/CD rules when the feature touches those concerns.
