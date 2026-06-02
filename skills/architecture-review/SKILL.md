---
name: architecture-review
description: Review backend architecture for bounded context boundaries, feature folder consistency, module dependencies, shared-code risk, and implementation drift. Use for architecture reviews and PR reviews touching structure.
---

# Architecture Review

Review for real risks and inconsistencies. Findings should lead the response and be grounded in file evidence.

## 10 Principles Checklist

- Well-Defined Boundaries: public exports are stable and internals remain private.
- Composability: apps compose contexts without embedding business logic.
- Independence: contexts can be built, tested, and operated independently.
- Individual Scale: context-level resource configuration is isolated.
- Explicit Communication: cross-context calls use contracts, HTTP, messaging, or events.
- Replaceability: providers and infrastructure details are hidden behind stable boundaries.
- Deployment Independence: contexts do not hard-code deployment assumptions.
- State Isolation: each context owns schema, migrations, and entity names.
- Observability And Monitoring: health, logs, metrics, and correlation are context-aware.
- Fail Independence: external and inter-context calls use timeouts, fallbacks, or circuit breakers where needed.

## Structure Checklist

- Feature complexity matches the current business need.
- Bounded contexts are clear and independently owned.
- Apps compose contexts without embedding domain logic.
- One NestJS module per bounded context, unless the project documents an app-layer exception.
- Feature folders contain their own core/http/persistence code.
- No direct cross-context imports.
- Cross-context queries use HTTP clients with timeout/circuit breaker.
- Asynchronous side effects use outbox/inbox or documented messaging strategy.
- No repositories injected into controllers.
- Tenant-scoped data is isolated by tenant-aware repositories or equivalent rules.
- Lifecycle entities use explicit transitions instead of ad-hoc status changes.
- Services throw structured exceptions rather than plain `Error`.
- Public API changes follow API versioning and response contract rules.
- Object storage uses a shared abstraction with context-specific orchestration.
- Health checks, logs, metrics, and correlation IDs cover apps, contexts, messaging, and providers.
- Shared code is not accumulating business rules.
- Reusable external providers live in `libs/integrations`, not in `libs/shared` or one bounded context when multiple apps/contexts can use them.
- Context-specific external adapters live under `domains/{context}/src/infrastructure/external`.
- Exports do not leak internal entities/repositories unnecessarily.
- Cross-context communication uses contracts, HTTP clients, messaging, or documented integration patterns.
- New or changed decisions/patterns are documented in the correct docs category.
- Docs match implementation.

## Output

1. Findings ordered by severity.
2. Open questions or assumptions.
3. Short summary of architecture health.
4. Recommended next actions with priority and effort.
