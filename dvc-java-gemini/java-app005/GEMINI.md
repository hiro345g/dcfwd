# GEMINI.md

This file provides instructions for Gemini on how to interact with this Java project.

## Project Overview

This project serves as a template for a standalone Java console application, built using the Spring Boot framework and Gradle. It is configured to run as a `CommandLineRunner`, making it suitable for command-line tasks. The project includes essential functionalities like logging with SLF4J and Logback, and a testing framework based on JUnit 5.

## Development Environment

- **JDK Version**: This project requires **Java 21**.
- **Environment**: The use of a **Dev Container** is recommended for a consistent development environment.

## Dependencies

The project dependencies are managed by Gradle in `gradle/libs.versions.toml` and `build.gradle`. Key dependencies include:

- **Spring Boot Gradle Plugin**: Manages dependency versions and provides Spring Boot specific tasks.
- **Spring Boot Starter**: Core starter for Spring Boot applications.
- **Spring Boot DevTools**: Provides fast application restarts, LiveReload, and configurations for a better development experience.
- **Spring Boot Starter Test**: For testing Spring Boot applications with libraries like JUnit 5, Mockito, and Spring Test.
- **Lombok**: To reduce boilerplate code.
- **Checkstyle**: `com.puppycrawl.tools:checkstyle`

## Coding Style

This project uses the **Google Java Style Guide**. Compliance is enforced by **Checkstyle**.

The style check is automatically run as part of the build. To run the check, execute:

```sh
./gradlew check
```

## Logging Policy

This project uses SLF4J and Logback for logging, which is the default for Spring Boot. The configuration is in `src/main/resources/logback.xml`, and logs are written to the console and to the `logs/app.log` file.

Log levels are used as follows:

- `ERROR`: For fatal errors that prevent the system from continuing.
- `WARN`: For potential problems.
- `INFO`: For normal operational information (e.g., application start/stop).
- `DEBUG`: For detailed information useful for debugging.
- `TRACE`: For even more fine-grained information than DEBUG.

## Testing Policy

1. **Framework**: Tests are written using **JUnit 5**, which is included in `spring-boot-starter-test`.
2. **Scope**: The focus is on unit and integration tests.
3. **Location**: Test classes are located in the `src/test/java` directory.
4. **Configuration**: Test-specific configurations can be placed in `src/test/resources`. For example, properties in `src/test/resources/application.properties` will override the main application properties during test execution.
5. **Execution**: Run tests using `./gradlew test`. All tests must pass for a change to be considered complete.
6. **Test Reports**: An HTML test report is generated at `build/reports/tests/test/index.html` after running the tests.

## Documentation Policy

1. **Format**: Public APIs (classes, methods, and fields) should be documented using **Javadoc** comments.
2. **Style**: Follow the conventions outlined in the **Google Java Style Guide's** section on Javadoc.
3. **Generation**: To generate the Javadoc documentation manually, run the following command. The output will be in the `build/docs/javadoc` directory.

    ```sh
    ./gradlew javadoc
    ```

## Profiles

This project uses Gradle properties and Spring Boot profiles to manage different configurations.

### Spring Boot Profiles

Spring Boot profiles are used to control application properties and logging configuration by loading profile-specific property files from the `src/main/resources` directory.

- **`dev`**: The default profile for development. It uses settings from `application-dev.properties`.
- **`prod`**: The profile for production. It uses settings from `application-prod.properties`.

### Gradle Properties for Profiles

Gradle properties are used to control the build process and how the application is run.

- **`dev`**: This profile is **active by default**. It packages the application so that the `dev` Spring Boot profile is active.
- **`prod`**: This profile packages the application for production. It activates the `prod` Spring Boot profile. To use it, add `-Pprofile=prod` to your Gradle command.
  ```sh
  # Build the application with the prod profile
  ./gradlew build -Pprofile=prod
  ```
- **`debug`**: This property runs the application in debug mode, listening for a debugger on port `5005`. It does not affect the packaging of the application.
  ```sh
  # Run the application in debug mode
  ./gradlew bootRun -Pdebug
  ```

## Build

To build the project, use the `build` command. This command downloads dependencies, runs Checkstyle, compiles the source code, and packages it into a JAR file.

By default (without specifying a profile), the application is packaged with the `dev` Spring Boot profile active.

```sh
# Build with the default dev profile
./gradlew build
```

To build for production, activate the `prod` profile. This will package the application with the `prod` Spring Boot profile active.

```sh
# Build with the prod profile
./gradlew build -Pprofile=prod
```

## Run

To run the application, use the `bootRun` command. By default, this will use the `dev` profile.

```sh
./gradlew bootRun
```

To run with a specific profile, such as `prod`, use the `-Pprofile` flag:

```sh
./gradlew bootRun -Pprofile=prod
```

## Test

To run the project's tests, use the following command.

```sh
./gradlew test
```

## Project Structure

```text
java-app005/
├── build/
├── gradle/
│   ├── libs.versions.toml
│   ├── wrapper/
│   │   ├── gradle-wrapper.jar
│   │   └── gradle-wrapper.properties
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── dev/
│   │   │       └── internal/
│   │   │           └── javaapp005/
│   │   │               └── JavaApp005Application.java
│   │   └── resources/
│   │       ├── application-dev.properties
│   │       ├── application-prod.properties
│   │       ├── application.properties
│   │       └── logback.xml
│   └── test/
│       ├── java/
│       │   └── dev/
│       │       └── internal/
│       │           └── javaapp005/
│       │               └── JavaApp005ApplicationTests.java
│       └── resources/
│           └── application.properties
├── .gitignore
├── build.gradle
├── google_checks.xml
├── gradlew
├── gradlew.bat
├── README.md
└── settings.gradle
```