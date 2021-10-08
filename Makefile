DOCKERDIR:=./build
.DEFAULT_GOAL:=help

.PHONY: help
help: ## Format and display the manual pages
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST)|awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: 
protoc: pb/hello.proto ## Generate protoc file 
	protoc --go_out=plugins=grpc:pb pb/hello.proto

.PHONY: build
build: ## Build server/client services.
	go build -o hello_server server/main.go
	go build -o hello_client client/main.go
