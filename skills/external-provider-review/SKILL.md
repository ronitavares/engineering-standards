---
name: external-provider-review
description: Review or design reusable external integration providers and context-specific adapters. Use when working with integrations such as payment gateways, antifraud, seating, wallet, insurance, CRM, or other external services.
---

# External Provider Review

External integrations should be reusable without moving business rules out of the owning bounded context.

## Decision Workflow

1. Identify whether the integration is reusable by multiple apps or contexts.
2. If reusable, place the provider implementation under `libs/integrations/src/{capability}/{provider}`.
3. If specific to one context only, it may live under `domains/{context}/src/infrastructure/external/{capability}/{provider}`.
4. Keep context business decisions in the owning bounded context.
5. Keep generic infrastructure clients in `libs/shared`, not `libs/integrations`.

## Review Checklist

- Provider code does not import bounded context entities.
- Provider code exposes neutral input/output types or interfaces.
- Business rules stay in use cases, services, or context adapters.
- Provider authentication/configuration is isolated and testable.
- Provider errors are mapped to stable integration errors.
- Sensitive credentials are read from configuration, not hard-coded.
- Tests cover request mapping, response mapping, and failure cases.

## Suggested Structure

```txt
libs/integrations/src/{capability}/{provider}/
├── {provider}-{capability}.provider.ts
├── {provider}-{capability}.client.ts
├── {provider}-{capability}.mapper.ts
├── {provider}-{capability}.config.ts
├── {provider}-{capability}.types.ts
└── index.ts
```

Context-specific adaptation:

```txt
domains/{context}/src/infrastructure/external/{capability}/
├── {context}-{capability}.provider-factory.ts
├── {context}-{capability}.mapper.ts
└── {context}-{capability}.config.ts
```

## Output

Return placement recommendation, ownership, interface shape, risk notes, and tests to add.
