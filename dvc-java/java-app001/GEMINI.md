# GEMINI.md

This file provides instructions for Gemini on how to interact with this Java project.

## Project Overview

This is a simple Java application that prints a basic "Hello, World!" to the console. This project also includes logging functionality with SLF4J and Logback.

## Development Environment

- **JDK Version**: This project requires **Java 21**.
- **Environment**: The use of a **Dev Container** is recommended for a consistent development environment.

## Dependencies

The project dependencies are managed by the `script/build.sh` script and downloaded into the `lib/` directory. Key dependencies include:

- **Checkstyle**: `10.17.0`
- **SLF4J API**: `2.0.17`
- **Logback**: `1.5.6`
- **JUnit**: `4.13.2`
- **Hamcrest Core**: `1.3`

## Coding Style

This project uses the **Google Java Style Guide**. Compliance is enforced by **Checkstyle**.

The style check is automatically run as part of the build script. To run the check, execute:

```sh
bash script/build.sh
```

## Logging Policy

This project uses SLF4J and Logback for logging. The configuration is in `src/logback.xml`, and logs are written to the console and to the `logs/app.log` file.

Log levels are used as follows:

- `ERROR`: For fatal errors that prevent the system from continuing.
- `WARN`: For potential problems.
- `INFO`: For normal operational information (e.g., application start/stop).
- `DEBUG`: For detailed information useful for debugging.
- `TRACE`: For even more fine-grained information than DEBUG.

## Testing Policy

1. **Framework**: Tests are written using **JUnit 4**.
2. **Scope**: The focus is on unit tests. Each new class `Foo.java` should have a corresponding test class `FooTest.java`.
3. **Location**: Test classes are located in the `src/` directory alongside the source code.
4. **Execution**: Run tests using `bash script/test.sh`. This script first builds the entire project and then executes the tests. All tests must pass for a change to be considered complete.

## Build

To build the project, run the following script. This script downloads dependencies, runs the Checkstyle linter, and compiles the source code.

```sh
./script/build.sh
```

## Run

To run the application, use the following script:

```sh
./script/run.sh
```

## Test

To run the project's tests, use the following script. This script first runs the main build script and then executes the JUnit tests.

```sh
./script/test.sh
```

## Project Structure

```text
java-app001/
├── bin/          # Compiled class files
├── lib/          # Dependency libraries (JARs)
├── logs/         # Log files
├── script/       # Shell scripts for build, run, and test
│   ├── build.sh
│   ├── run.sh
│   └── test.sh
├── src/          # Java source code
│   ├── App.java
│   ├── AppTest.java
│   └── logback.xml
├── .gitignore
├── google_checks.xml
├── java-app001.code-workspace
└── README.md
```
