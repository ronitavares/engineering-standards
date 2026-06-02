# Engineering Standards Pack

Reusable development standards for backend projects that follow modular architecture, bounded contexts, feature folders, feature complexity calibration, TypeScript, NestJS, relational persistence, messaging/outbox, multi-tenancy, reusable external integrations, storage abstraction, REST APIs, API versioning, Swagger/OpenAPI, response contracts, observability, security/auth, configuration and secrets, privacy/LGPD, caching/performance, jobs/scheduling, CI/CD, migrations, seeds, automated tests, documentation governance, language consistency, and technical governance.

This package is intentionally framework-aware but project-agnostic. Copy or sync the relevant files into each repository, then adapt only the project-specific names, paths, commands, and bounded contexts.

## Package Structure

```txt
engineering-standards/
├── rules/       # Persistent Cursor rules for project guidance
├── skills/      # Agent workflows for repeated engineering tasks
├── hooks/       # Hook templates for automatic guardrails
├── libs/        # Recommended reusable library layout examples
├── scripts/     # Deterministic validation scripts
└── templates/   # Report and checklist templates
```

## Recommended Installation

1. Copy selected rules to `.cursor/rules/`.
2. Copy selected skills to `.cursor/skills/`.
3. Copy hook templates to `.cursor/hooks/` and wire them in `.cursor/hooks.json`.
4. Copy scripts to `tools/engineering-standards/` or keep them under this package and reference them from hooks/CI.
5. Use `libs/integrations/README.md` as the reference structure for reusable external providers.
6. Add project-specific commands to `package.json`, `Makefile`, or CI.

## First Preset

The initial preset targets:

- Nx or monorepo-style backend workspaces.
- NestJS services.
- The 10 Principles of Modular Architecture.
- Bounded contexts under `domains/`.
- Feature folders with `core`, `http`, and `persistence`.
- Feature complexity classification before adding advanced patterns.
- Optional Use Case Pattern for non-trivial application workflows.
- Cross-context communication through explicit contracts, HTTP, events, or queues.
- Transactional outbox/inbox for reliable asynchronous side effects.
- Multi-tenancy through tenant-aware data access.
- State machine lifecycle only for entities with real transition rules.
- Structured exception handling.
- Architecture anti-pattern detection.
- Reusable external providers under `libs/integrations`.
- Storage abstraction under `libs/shared/src/storage`.
- API versioning and response envelope for public/gateway APIs.
- Context-aware observability.
- Production security, authentication, authorization, and request hardening.
- Typed configuration, secrets governance, and feature flags.
- Data privacy and LGPD-oriented handling of personal data.
- Caching, pagination, performance budgets, and query efficiency.
- Background jobs and scheduled task governance.
- CI/CD gates, dependency governance, vulnerability scanning, and contract testing.
- TypeORM or equivalent relational persistence.
- Separate migration and seed governance.
- Swagger/OpenAPI documentation.
- Jest/e2e testing.
- English-by-default language consistency, with explicit support for user-requested output in another language.
- Zod usage boundaries for external payloads, config validation, frontend forms, and runtime schemas.

## Core Principle

Rules describe what must always be true. Skills describe how to perform repeatable work. Hooks and scripts enforce the highest-risk rules automatically. MCP or plugins should come later, after these standards have been validated across multiple projects.

## First Evolution Batch

The first evolution batch adds reusable standards extracted from project docs:

- `documentation-governance.mdc`
- `language-consistency.mdc`
- `feature-complexity.mdc`
- `cross-context-communication.mdc`
- `messaging-outbox.mdc`
- `exception-handling.mdc`
- `multi-tenancy.mdc`
- `state-machine-lifecycle.mdc`
- `architecture-anti-patterns.mdc`

## Second Evolution Batch

The second evolution batch adds more specific standards that should be enabled when the project has public APIs, object storage, or production observability needs:

- `api-versioning.mdc`
- `response-envelope.mdc`
- `zod-usage.mdc`
- `storage-abstraction.mdc`
- `observability.mdc`
- enhanced `testing-guidelines.mdc`

## Production Readiness Batch

The production readiness batch turns the package from an architectural core into a fuller end-to-end backend standard:

- `security-authn-authz.mdc`
- `configuration-secrets.mdc`
- `ci-cd.mdc`
- `data-privacy-lgpd.mdc`
- `caching-performance.mdc`
- `jobs-scheduling.mdc`

## Boundary Validation

`scripts/validate-boundaries.sh` accepts project-specific bounded contexts and package scope:

```bash
scripts/validate-boundaries.sh . identity,catalog,sales,ordering @funbe
```

The same values can be provided through `ENGINEERING_STANDARDS_CONTEXTS` and `ENGINEERING_STANDARDS_PACKAGE_SCOPE`. When contexts are not provided, the script derives them from `domains/{context}` directories.

## Modular Architecture

The source of truth for architectural direction is `rules/modular-architecture-principles.mdc`.
It defines the 10 principles that every project should follow:

1. Well-Defined Boundaries
2. Composability
3. Independence
4. Individual Scale
5. Explicit Communication
6. Replaceability
7. Deployment Independence
8. State Isolation
9. Observability And Monitoring
10. Fail Independence

## Integration Ownership

Use this split consistently:

```txt
libs/shared/        # generic technical infrastructure: SQS, S3, HTTP base, logging, metrics
libs/integrations/  # reusable external providers: payment, antifraud, seating, wallet, CRM
domains/{context}/  # business rules and context-specific provider adaptation
infrastructure/     # operational infrastructure: Docker, Terraform, Kubernetes, LocalStack
```

Reusable providers such as FourAll, Paymee, ClearSale, Seats.io, Google Wallet, and RD Station should live in `libs/integrations/src/{capability}/{provider}` when more than one app or context can use them. Context-specific selection, orchestration, and business decisions stay in the owning bounded context.
