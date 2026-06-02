---
name: technical-codebase-mapping
description: Map a backend codebase into an objective technical report. Use when onboarding a new repository, auditing architecture, or asking for a Technical Codebase Mapping Report.
---

# Technical Codebase Mapping

Generate an evidence-based technical mapping report. Do not infer architecture only from folder names; verify real code, configs, scripts, and examples.

## Workflow

1. Inspect top-level structure, package manager, build system, and framework.
2. Read core config files: package scripts, TypeScript config, lint/format/test configs, Docker/Compose, CI, README, architecture docs.
3. Map deployable apps, domain libraries, shared libraries, reusable integration libraries, and contracts.
4. Read representative examples of controller, service, repository, entity, DTO, guard, interceptor/filter, external provider, migration, seed, and tests.
5. Check import aliases and module boundary enforcement.
6. Evaluate the 10 Principles of Modular Architecture with concrete file evidence.
7. Check documentation governance: intent, decisions, knowledge, status sections, and changelog.
8. Check feature complexity calibration and signs of over-engineering.
9. Check cross-context communication, messaging/outbox, exception handling, multi-tenancy, and lifecycle/state machine usage.
10. Check API versioning, response envelope usage, Swagger/OpenAPI setup, and decorator consistency.
11. Check storage abstraction and object-storage placement.
12. Check observability: request/correlation IDs, health checks, logs, metrics, tracing, and provider/queue visibility.
13. Check external provider placement: `libs/integrations` for reusable providers, `domains/{context}/src/infrastructure/external` for context adapters, `libs/shared` for generic technical infrastructure.
14. Check migrations and seeds separately.
15. Produce the report from observed evidence, explicitly marking what is found, inferred, absent, inconsistent, or weakly evidenced.

## Output

Use the template in `../../templates/technical-codebase-mapping-report.md` when available.

## Evidence Rules

- Cite files, not assumptions.
- Say `Não encontrado na base analisada.` when absent.
- Say `Inferência baseada em ...` when inferred.
- Say `Inconsistência identificada entre ...` when evidence conflicts.
- Evaluate principles as Strong, Partial, Weak, Absent, or Inconsistent.
- Avoid recommending CQRS, microservices, event sourcing, or Clean Architecture unless the codebase need is evidenced.
