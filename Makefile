# 22route/core — OpenAPI spec and generated Go types/client
# Repo: github.com/22route/core

.PHONY: gen build build-docs docs-spec tidy

OAPI_CODEGEN := $(shell command -v oapi-codegen 2>/dev/null || echo "$(shell go env GOPATH)/bin/oapi-codegen")

# Generate Go code from openapi.yaml. Install: go install github.com/oapi-codegen/oapi-codegen/v2/cmd/oapi-codegen@latest
gen:
	@test -x "$(OAPI_CODEGEN)" || go install github.com/oapi-codegen/oapi-codegen/v2/cmd/oapi-codegen@latest
	$(OAPI_CODEGEN) -config oapi-codegen.yaml openapi.yaml
	@echo "Generated pkg/api/core.gen.go"

# Same via go run (no install)
gen-go:
	go run github.com/oapi-codegen/oapi-codegen/v2/cmd/oapi-codegen -config oapi-codegen.yaml openapi.yaml
	@echo "Generated pkg/api/core.gen.go"

build: build-docs
	go build ./...

# Sync spec into cmd/tt-api-docs and pkg/docs for embedding
docs-spec:
	@cp openapi.yaml cmd/tt-api-docs/spec/openapi.yaml
	@cp openapi.yaml pkg/docs/spec/openapi.yaml
	@echo "Synced openapi.yaml -> cmd/tt-api-docs/spec/, pkg/docs/spec/"

# Build tt-api-docs binary (Swagger UI server)
build-docs: docs-spec
	@mkdir -p bin
	go build -o bin/tt-api-docs ./cmd/tt-api-docs
	@echo "Built bin/tt-api-docs"

tidy:
	go mod tidy
