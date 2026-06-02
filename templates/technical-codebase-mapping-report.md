# Technical Codebase Mapping Report

## 1. Executive Summary

Describe application type, framework, language, architectural style, modularity, strengths, risks, and gaps.

## 2. Architecture

| Architecture/Pattern | Evidence | Status | Notes |
|---|---|---|---|
| Bounded Contexts |  |  |  |
| Feature Folders |  |  |  |
| Layered Architecture |  |  |  |
| Event-driven |  |  |  |
| Repository Pattern |  |  |  |
| Use Case Pattern |  |  |  |
| External Integrations |  |  |  |
| Cross-Context Communication |  |  |  |
| Transactional Outbox / Inbox |  |  |  |
| Multi-Tenancy |  |  |  |
| State Machine / Lifecycle |  |  |  |
| Exception Handling |  |  |  |
| API Versioning |  |  |  |
| Response Envelope |  |  |  |
| Storage Abstraction |  |  |  |
| Observability |  |  |  |
| CQRS |  |  |  |

Statuses: Strong, Partial, Weak, Absent, Inconsistent.

## 3. Application Design

```txt
HTTP Request
  -> Controller
  -> DTO Validation
  -> Guard/Auth
  -> Use Case or Service
  -> Domain Logic
  -> Repository
  -> Database
  -> Response DTO / Mapper
```

Compare expected flow with real implementation.

## 4. Project Structure Organization

```txt
repo/
├── apps/
├── domains/
├── libs/
│   ├── shared/
│   └── integrations/
├── docs/
└── tools/
```

| Directory | Apparent Responsibility | Notes |
|---|---|---|
|  |  |  |

## 5. Identified Patterns

Group by architectural, design, NestJS, persistence, external integration, API, and testing patterns.

## 6. Domain Management

| Domain | Location | Responsibility | Dependencies | Notes |
|---|---|---|---|---|
|  |  |  |  |  |

## 7. Principles

| Principle | Evidence | Status | Comment |
|---|---|---|---|
| 1. Well-Defined Boundaries |  |  |  |
| 2. Composability |  |  |  |
| 3. Independence |  |  |  |
| 4. Individual Scale |  |  |  |
| 5. Explicit Communication |  |  |  |
| 6. Replaceability |  |  |  |
| 7. Deployment Independence |  |  |  |
| 8. State Isolation |  |  |  |
| 9. Observability And Monitoring |  |  |  |
| 10. Fail Independence |  |  |  |

Evaluate each principle from concrete evidence. Use Strong, Partial, Weak, Absent, or Inconsistent.

## 8. Build & Run

| Script/Command | Purpose | Notes |
|---|---|---|
|  |  |  |

## 9. Common Feature Development Workflow

List the real workflow based on the codebase.

## 10. Swagger / OpenAPI Documentation

Document setup, endpoints, decorators, exports, and gaps.

## 11. Development Guidelines

Map explicit docs, ADRs, lint rules, PR/CI conventions, and implicit conventions.

### Standards Coverage

| Standard | Evidence | Status | Notes |
|---|---|---|---|
| Documentation Governance |  |  |  |
| Feature Complexity |  |  |  |
| Cross-Context Communication |  |  |  |
| Messaging / Outbox |  |  |  |
| Exception Handling |  |  |  |
| Multi-Tenancy |  |  |  |
| State Machine Lifecycle |  |  |  |
| Architecture Anti-Patterns |  |  |  |
| API Versioning |  |  |  |
| Response Envelope |  |  |  |
| Storage Abstraction |  |  |  |
| Observability |  |  |  |

## 12. Setup

List local setup steps and gaps.

## 13. Migrations

Analyze schema migration strategy only. Do not mix with seeds.

| Aspect | Evidence | Status | Notes |
|---|---|---|---|
|  |  |  |  |

## 14. Seeds

Analyze data setup and reconciliation strategy only. Do not mix with migrations.

| Aspect | Evidence | Status | Notes |
|---|---|---|---|
|  |  |  |  |

## 15. Testing

| Test Type | Location | Tool | Status | Notes |
|---|---|---|---|---|
|  |  |  |  |  |

Check whether unit, integration, and e2e tests are used at the correct layer. Flag over-mocking of repositories, tenant context, and state machines.

## 16. External Integrations

Analyze reusable provider implementations and context-specific adapters.

| Integration | Provider Location | Context Adapter Location | Responsibility | Notes |
|---|---|---|---|---|
|  |  |  |  |  |

Expected placement:

- `libs/integrations/src/{capability}/{provider}` for reusable provider implementations.
- `domains/{context}/src/infrastructure/external/{capability}` for context-specific adaptation and business-facing orchestration.
- `libs/shared/src/{messaging|storage|http|observability}` for generic technical infrastructure.
- Root `infrastructure/` for operational infrastructure.

## 17. API Contracts

Analyze versioning, Swagger/OpenAPI, response shape, public API compatibility, and event contract compatibility.

| Aspect | Evidence | Status | Notes |
|---|---|---|---|
| API Versioning |  |  |  |
| Response Envelope |  |  |  |
| Swagger/OpenAPI |  |  |  |
| Event Contract Versioning |  |  |  |
| Deprecation Policy |  |  |  |

## 18. Storage And Observability

| Aspect | Evidence | Status | Notes |
|---|---|---|---|
| Storage Abstraction |  |  |  |
| S3/Object Storage Placement |  |  |  |
| Correlation / Request IDs |  |  |  |
| Health Checks |  |  |  |
| Metrics / Tracing |  |  |  |
| Structured Logs |  |  |  |

## 19. Guardrails

| Guardrail | Evidence | Status | Risk If Absent |
|---|---|---|---|
|  |  |  |  |

## 20. Code Style

Describe naming, formatting, imports, error handling, DTOs, logs, and response patterns.

## 21. Import Path Aliases

| Alias | Path | Usage | Notes |
|---|---|---|---|
|  |  |  |  |

## 22. Module Boundary Rules

| Rule | Status | Evidence | Notes |
|---|---|---|---|
|  |  |  |  |

## 23. Implementation Map

| Responsibility | Location | Examples | Notes |
|---|---|---|---|
|  |  |  |  |

## 24. Risk Assessment

| Risk | Severity | Evidence | Impact | Recommendation |
|---|---|---|---|---|
|  |  |  |  |  |

## 25. Gaps And Recommendations

| Recommendation | Priority | Effort | Impact | Justification |
|---|---|---|---|---|
|  |  |  |  |  |

## 26. Evidence Index

- `package.json`:
- `tsconfig*`:
- `eslint/prettier`:
- `main.ts`:
- `app.module.ts`:
- `domains/`:
- `libs/integrations/`:
- `migrations/`:
- `seeds/`:
- `tests/`:
