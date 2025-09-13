#!/bin/bash
SCRIPT_DIRNAME=$(dirname "$0")
PROJECT_DIR=$(cd "${SCRIPT_DIRNAME}/.." || exit 1;pwd)

# --- Create directories ---
echo "Creating directories..."
if [ ! -e "${PROJECT_DIR}/bin" ]; then mkdir -p "${PROJECT_DIR}/bin"; fi
if [ ! -e "${PROJECT_DIR}/lib" ]; then mkdir -p "${PROJECT_DIR}/lib"; fi
if [ ! -e "${PROJECT_DIR}/logs" ]; then mkdir -p "${PROJECT_DIR}/logs"; fi

# --- Download dependencies ---
echo "Checking dependencies..."
# SLF4J API (Interface)
if [ ! -e "${PROJECT_DIR}/lib/slf4j-api-2.0.17.jar" ]; then
  echo "Downloading slf4j-api..."
  curl -L -o "${PROJECT_DIR}/lib/slf4j-api-2.0.17.jar" https://repo1.maven.org/maven2/org/slf4j/slf4j-api/2.0.17/slf4j-api-2.0.17.jar
fi

# Logback (Implementation)
LOGBACK_VERSION="1.5.6"
if [ ! -e "${PROJECT_DIR}/lib/logback-core-${LOGBACK_VERSION}.jar" ]; then
  echo "Downloading logback-core..."
  curl -L -o "${PROJECT_DIR}/lib/logback-core-${LOGBACK_VERSION}.jar" "https://repo1.maven.org/maven2/ch/qos/logback/logback-core/${LOGBACK_VERSION}/logback-core-${LOGBACK_VERSION}.jar"
fi
if [ ! -e "${PROJECT_DIR}/lib/logback-classic-${LOGBACK_VERSION}.jar" ]; then
  echo "Downloading logback-classic..."
  curl -L -o "${PROJECT_DIR}/lib/logback-classic-${LOGBACK_VERSION}.jar" "https://repo1.maven.org/maven2/ch/qos/logback/logback-classic/${LOGBACK_VERSION}/logback-classic-${LOGBACK_VERSION}.jar"
fi

# JUnit (for testing)
if [ ! -e "${PROJECT_DIR}/lib/junit-4.13.2.jar" ]; then
  echo "Downloading junit..."
  curl -L -o "${PROJECT_DIR}/lib/junit-4.13.2.jar" "https://repo1.maven.org/maven2/junit/junit/4.13.2/junit-4.13.2.jar"
fi
if [ ! -e "${PROJECT_DIR}/lib/hamcrest-core-1.3.jar" ]; then
  echo "Downloading hamcrest-core..."
  curl -L -o "${PROJECT_DIR}/lib/hamcrest-core-1.3.jar" "https://repo1.maven.org/maven2/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar"
fi

# Checkstyle
CHECKSTYLE_VERSION="10.17.0"
CHECKSTYLE_JAR="checkstyle-${CHECKSTYLE_VERSION}-all.jar"
if [ ! -e "${PROJECT_DIR}/lib/${CHECKSTYLE_JAR}" ]; then
  echo "Downloading Checkstyle..."
  curl -L -o "${PROJECT_DIR}/lib/${CHECKSTYLE_JAR}" "https://github.com/checkstyle/checkstyle/releases/download/checkstyle-${CHECKSTYLE_VERSION}/${CHECKSTYLE_JAR}"
fi

# --- Run Checkstyle ---
echo "Running Checkstyle..."
if ! java -jar "${PROJECT_DIR}/lib/${CHECKSTYLE_JAR}" -c "${PROJECT_DIR}/google_checks.xml" "src/"; then
  echo "Checkstyle found violations. Build failed."
  exit 1
fi
echo "Checkstyle passed."

# --- Compile & Copy Resources ---
echo "Compiling source code..."
CP="${PROJECT_DIR}/src"
for f in "${PROJECT_DIR}/lib"/*; do
  CP="$f:${CP}"
done
javac -d "${PROJECT_DIR}/bin" -cp "${CP}" "${PROJECT_DIR}/src/App.java" "${PROJECT_DIR}/src/AppTest.java"

echo "Copying resources..."
cp "${PROJECT_DIR}/src/logback.xml" "${PROJECT_DIR}/bin/"

echo "Build successful!"
