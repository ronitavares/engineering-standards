---
name: api-contract-review
description: Review REST API contracts, Swagger/OpenAPI decorators, DTO validation, response schemas, and versioning risk. Use when changing controllers, DTOs, or public API behavior.
---

# API Contract Review

Review the API as a stable contract, not just code.

## Workflow

1. Identify changed controllers, DTOs, guards, interceptors, and response mappers.
2. Verify validation decorators match the documented Swagger schema.
3. Check success and error responses.
4. Confirm auth requirements are represented in Swagger.
5. Check whether response envelope, pagination, and API versioning rules apply.
6. Check rate limits, CORS exposure, sensitive fields, and PII masking for public or partner APIs.
7. Identify breaking changes and whether versioning, contract tests, or migration notes are needed.

## Checklist

- Every DTO field has validation and API metadata where relevant.
- Examples are realistic and do not expose secrets.
- Enums, arrays, nullability, formats, and nested DTOs are documented.
- Error responses use project-standard shape.
- Public/partner APIs include operation summaries and tags.
- Controllers return response DTOs rather than persistence entities.
- Internal contract changes are additive-only or explicitly deprecated before removal.
- Public breaking changes use URL versioning or an approved migration plan.
- Existing request DTOs do not gain required fields without versioning.
- Event contracts include versioning and tolerate unknown fields.
- Cross-context or partner-facing contracts have consumer/provider test coverage when independently released.
- Public/gateway APIs use the response envelope when the project standard requires it.

## Output

Findings first, then gaps, then recommended fixes and verification commands.
