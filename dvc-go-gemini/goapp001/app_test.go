package main

import (
	"bytes"
	"strings"
	"testing"

	"github.com/rs/zerolog"
	"github.com/stretchr/testify/assert"
)

func TestRun(t *testing.T) {
	// Setup: Create a buffer to capture log output and a logger that writes to it.
	var logBuffer bytes.Buffer
	// Set a fixed log level for the test logger to ensure all messages are captured.
	testLogger := zerolog.New(&logBuffer).Level(zerolog.DebugLevel)

	// Execute the Run function with the test logger.
	Run(testLogger)

	// Get the captured log output as a string.
	logOutput := logBuffer.String()

	// Assert: Check if the output contains the expected log messages.
	assert.True(t, strings.Contains(logOutput, "Application is running."), "Log should contain 'Application is running.'")
	assert.True(t, strings.Contains(logOutput, "This is a debug message from app.go."), "Log should contain debug message")
	assert.True(t, strings.Contains(logOutput, "This is an info message from app.go."), "Log should contain info message")
	assert.True(t, strings.Contains(logOutput, "This is a warning message from app.go."), "Log should contain warning message")
	assert.True(t, strings.Contains(logOutput, "Application finished."), "Log should contain 'Application finished.'")
	assert.True(t, strings.Contains(logOutput, "\"user\":\"Gopher\""), "Log should contain the user field")
}
