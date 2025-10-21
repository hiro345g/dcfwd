# GEMINI.md

This file provides instructions for Gemini on how to interact with this Java project.

## Project Overview

This is a simple Java application that prints a basic "Hello, World!" to the console. This project also includes logging functionality with SLF4J and Logback.

## Development Environment

- **JDK Version**: This project requires **Java 21**.
- **Environment**: The use of a **Dev Container** is recommended for a consistent development environment.

## Dependencies

The project dependencies are managed by Gradle in `app/build.gradle` and `gradle/libs.versions.toml`. Key dependencies include:

- **Checkstyle**: `com.puppycrawl.tools:checkstyle:10.17.0`
- **Guava**: `com.google.guava:guava:33.4.5-jre`
- **SLF4J API**: `org.slf4j:slf4j-api:2.0.17`
- **Logback**: `ch.qos.logback:logback-classic:1.5.6`
- **JUnit**: `junit:junit:4.13.2`
- **Hamcrest Core**: `org.hamcrest:hamcrest-core:1.3`

## Coding Style

This project uses the **Google Java Style Guide**. Compliance is enforced by **Checkstyle**.

The style check is automatically run as part of the build. To run the check, execute:

```sh
./gradlew check
```

## Logging Policy

This project uses SLF4J and Logback for logging. The configuration is in `app/src/main/resources/logback.xml`, and logs are written to the console and to the `logs/app.log` file.

Log levels are used as follows:

- `ERROR`: For fatal errors that prevent the system from continuing.
- `WARN`: For potential problems.
- `INFO`: For normal operational information (e.g., application start/stop).
- `DEBUG`: For detailed information useful for debugging.
- `TRACE`: For even more fine-grained information than DEBUG.

## Testing Policy

1. **Framework**: Tests are written using **JUnit 4**.
2. **Scope**: The focus is on unit tests. Each new class `Foo.java` should have a corresponding test class `FooTest.java`.
3. **Location**: Test classes are located in the `app/src/test/java` directory.
4. **Execution**: Run tests using `./gradlew test`. All tests must pass for a change to be considered complete.

## Documentation Policy

1. **Format**: Public APIs (classes, methods, and fields) should be documented using **Javadoc** comments.
2. **Style**: Follow the conventions outlined in the **Google Java Style Guide's** section on Javadoc. This ensures consistency with the overall code style.
3. **Generation**: The `maven-javadoc-plugin` is configured in `pom.xml` to generate a Javadoc JAR from the source code.
4. **Build Integration**: The Javadoc JAR is automatically generated as part of the `mvn clean install` command.
5. **Manual Generation**: To generate the Javadoc documentation manually, run the following command. The output will be in the `target/site/apidocs` directory.

```sh
./gradlew javadoc
```

## Build

To build the project, run the following command. This command downloads dependencies, runs the Checkstyle linter, and compiles the source code.

```sh
./gradlew build
```

## Run

To run the application, use the following command:

```sh
./gradlew run
```

## Test

To run the project's tests, use the following command.

```sh
./gradlew test
```

Test results are displayed in detail in the console.

**Note:** If the source code has not changed, Gradle may skip running the tests (the result will be displayed as `UP-TO-DATE`). To force the tests to be re-run in that case, use the following command:

```sh
./gradlew cleanTest test
```

## Project Structure

```text
java-app002/
├── GEMINI.md
├── README.md
├── .gitattributes
├── .gitignore
├── app/
│   ├── build.gradle
│   ├── logs/
│   │   └── app.log
│   └── src/
│       ├── main/
│       │   ├── java/
│       │   │   └── internal/
│       │   │       └── dev/
│       │   │           └── App.java
│       │   └── resources/
│       │       └── logback.xml
│       └── test/
│           ├── java/
│           │   └── internal/
│           │       └── dev/
│           │           └── AppTest.java
│           └── resources/
├── google_checks.xml
├── gradle/
│   ├── libs.versions.toml
│   └── wrapper/
│       ├── gradle-wrapper.jar
│       └── gradle-wrapper.properties
├── gradle.properties
├── gradlew
├── gradlew.bat
├── java-app002.code-workspace
└── settings.gradle
```
