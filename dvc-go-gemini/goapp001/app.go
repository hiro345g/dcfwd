package main

import "github.com/rs/zerolog"

// Run executes the main application logic. It logs several messages at different levels
// to demonstrate the logging setup.
func Run(logger zerolog.Logger) {
	logger.Info().Msg("Application is running.")

	logger.Debug().Msg("This is a debug message from app.go.")
	logger.Info().Msg("This is an info message from app.go.")
	logger.Warn().Str("user", "Gopher").Msg("This is a warning message from app.go.")

	logger.Info().Msg("Application finished.")
}
