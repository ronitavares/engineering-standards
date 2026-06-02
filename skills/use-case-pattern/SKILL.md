---
name: use-case-pattern
description: Apply or review the Use Case Pattern in backend features. Use when adding application workflows, refactoring services into use cases, or deciding whether a feature action deserves a use case.
---

# Use Case Pattern

Use cases model application workflows. Apply them where they clarify orchestration and transaction boundaries; avoid adding them to trivial CRUD just for ceremony.

## Decision Workflow

1. Identify the business action.
2. Check whether the action coordinates multiple dependencies, writes, external calls, or domain rules.
3. If yes, create a use case named after the action.
4. If no, keep the logic in the feature service.
5. Keep reusable business rules in domain services or policy objects.

## Implementation Workflow

1. Create `domains/{context}/src/{feature}/core/use-case/{action}-{feature}.use-case.ts`.
2. Export an injectable class with one main `execute()` method.
3. Inject repositories, domain services, integration clients, event publishers, and mappers as needed.
4. Put transaction boundaries in the use case when the workflow spans multiple writes.
5. Keep HTTP decorators and request/response metadata in controllers/DTOs.
6. Register the use case provider in the owning context module.
7. Update the controller to call the use case.
8. Add focused unit tests for the use case.

## Review Checklist

- The use case name is a business action.
- The use case has a single clear responsibility.
- The controller remains thin.
- Domain rules are not duplicated across use cases.
- Transaction boundaries are explicit.
- Tests cover success and failure paths.
