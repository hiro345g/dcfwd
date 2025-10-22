# Gemini CLI Instructions

This file describes the rules and settings for me (Gemini CLI) to work on this project. Please update this file if the project conventions are changed or added.

## 1. Project Overview

This project is a simple Go application with environment-aware, configurable logging.

- **Configuration Management**: Centralized in the `config` package using `viper`. It loads settings from `conf/config.yaml` and allows overrides via environment variables (e.g., `APP_LEVEL`).
- **Logging**: `zerolog`, initialized via the singleton `logger` package.
- **Environment Variable**: `APP_ENV` (`dev`, `prod`) controls the logging output format (console + file vs. file only).

## 2. Dependencies and Tools

- **Go Version**: Please use `1.24.5`. Run with the `go1.24.5` command. If this command is not available, install it by running `go install golang.org/dl/go1.24.5@latest` and then `go1.24.5 download`.
- **Debugger**: Use `delve`. The version is managed in `go.mod`.

## 3. Development Workflow

### Running the application

- **Development Mode**: `APP_ENV=dev go1.24.5 run .`
- **Production Mode**: `APP_ENV=prod go1.24.5 run .`
- **Overriding config**: Any configuration parameter can be overridden with an environment variable prefixed with `APP_`. For example, to change the log level to debug:
  `APP_LEVEL=debug go1.24.5 run .`

### Testing

- **Standard Test**: `go test ./...`
- **Verbose Test**: `go test -v ./...`

### Debugging

- **Start a debug session**: `go run github.com/go-delve/delve/cmd/dlv debug`

### Docker-based Workflow

You can also use Docker to run and test the application in an isolated environment. The configurations are located in the `docker/` directory.

-   **Build Images:**
    ```bash
    docker compose -f docker/cicd/compose.yaml build
    docker compose -f docker/demo/compose.yaml build
    ```

-   **Running Tests (CI/CD):**
    ```bash
    docker compose -f docker/cicd/compose.yaml run --rm test
    ```

-   **Running a Demo (Development):**
    Runs the application in the default `dev` mode.
    ```bash
    docker compose -f docker/demo/compose.yaml run --rm app
    ```
    You can also override the environment variable to run in `prod` mode.
    ```bash
    docker compose -f docker/demo/compose.yaml run --rm -e APP_ENV=prod app
    ```

-   **Running in Production:**
    Builds and runs the production-ready image.
    ```bash
    # 1. Build the image
    docker compose -f docker/prod/compose.yaml build

    # 2. Run the application
    docker compose -f docker/prod/compose.yaml up
    ```

## 4. Coding Style and Conventions

- Please follow the standard Go format (`gofmt`).
- Please handle errors appropriately.
- Please write comments to explain the intent of the code.
- Please write `godoc`-compatible comments for public functions and variables.

## 5. Other

- If you have any questions, please ask each time.
