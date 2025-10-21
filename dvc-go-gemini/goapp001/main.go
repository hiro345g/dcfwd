package main

import (
	"go.dev.internal/goapp001/config"
	"go.dev.internal/goapp001/logger"
)

func main() {
	// Initialize config and logger
	cfg := config.GetConfig()
	log := logger.GetLogger()

	log.Info().Msgf("Starting application with config: %+v", cfg)

	Run(log)
}