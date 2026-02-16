# 22route/core

Shared OpenAPI contract and generated Go code for 22route.

**Repos:** [22route/core](https://github.com/22route/core) (this), [22route/control](https://github.com/22route/control), [22route/gateway](https://github.com/22route/gateway) (gateway + agent).

## Contents

- **openapi.yaml** — Gateway API (gateway/agent ↔ control plane): token validation, config, gateway registration, heartbeat.
- **pkg/api/** — Go types and HTTP client generated from the spec (oapi-codegen).
- **cmd/tt-api-docs/** — HTTP server with embedded Swagger UI for the API spec.

Used by:

- **gateway** — imports this module, uses `api` client to call the control plane.
- **control** — implements the same API (spec is the contract).

## Requirements

- Go 1.22+

## Codegen

From repo root:

```bash
make gen
```

Or without installing oapi-codegen:

```bash
make gen-go
```

Or install and run manually:

```bash
go install github.com/oapi-codegen/oapi-codegen/v2/cmd/oapi-codegen@latest
oapi-codegen -config oapi-codegen.yaml openapi.yaml
```

Generated file: **pkg/api/core.gen.go** (types + client). Do not edit by hand.

## Use as dependency

```bash
go get github.com/22route/core@v0.1.0
```

```go
import "github.com/22route/core/pkg/api"

client, _ := api.NewClientWithResponses("https://cp.example.com", api.WithRequestEditorFn(...))
resp, err := client.ValidateTokenWithResponse(ctx, api.ValidateTokenJSONRequestBody{Token: "..."})
```

## API docs (Swagger UI)

Build and run the docs server (embeds the spec and serves Swagger UI):

```bash
make build-docs
./bin/tt-api-docs
```

Then open http://localhost:8080 . Use `-addr` to change listen address, e.g. `./bin/tt-api-docs -addr :9090`.

After changing **openapi.yaml**, run `make build-docs` again so the embedded spec is updated.

## License

MIT
