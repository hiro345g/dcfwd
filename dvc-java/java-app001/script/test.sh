#!/bin/bash
SCRIPT_DIRNAME=$(dirname "$0")
PROJECT_DIR=$(cd "${SCRIPT_DIRNAME}/.." || exit 1;pwd)

# Run the build script first to ensure everything is compiled and up-to-date
echo "Running build script..."
if bash "${SCRIPT_DIRNAME}/build.sh"; then
    :
else
    echo "Build failed. Aborting tests."
    exit 1
fi

# Run the tests
echo "
Running tests..."
CP="${PROJECT_DIR}/bin"
for f in "${PROJECT_DIR}/lib"/*; do
  CP="$f:${CP}"
done
java -cp "${CP}" org.junit.runner.JUnitCore AppTest
