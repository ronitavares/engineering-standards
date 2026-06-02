# Integrations Library

Use this area as the recommended home for reusable external providers.

## Responsibility

`libs/integrations` contains provider implementations that can be reused by multiple applications or bounded contexts.

Examples:

```txt
libs/integrations/src/payment/fourall/
libs/integrations/src/payment/paymee/
libs/integrations/src/antifraud/clearsale/
libs/integrations/src/antifraud/cybersource/
libs/integrations/src/seating/seatsio/
libs/integrations/src/insurance/metlife/
libs/integrations/src/wallet/google-wallet/
libs/integrations/src/crm/rd-station/
```

## Boundary

Provider code may know about external APIs, SDKs, authentication, raw contracts, retries, and error mapping. It must not know about bounded context entities or business decisions.

Context-specific decisions stay in `domains/{context}/src/infrastructure/external/{capability}` or in the context use cases/services.
