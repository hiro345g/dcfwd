package logger

import (
	"io"
	"os"
	"path/filepath"
	"sync"

	"go.dev.internal/goapp001/config"
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
)

var (
	once   sync.Once
	logger zerolog.Logger
)

// GetLogger returns the singleton logger instance.
func GetLogger() zerolog.Logger {
	once.Do(func() {
		cfg := config.GetConfig()

		// Parse log level
		level, err := zerolog.ParseLevel(cfg.Level)
		if err != nil {
			level = zerolog.InfoLevel
			log.Warn().Msgf("Invalid log level '%s', defaulting to 'info'", cfg.Level)
		}

		// Create log directory
		if err := os.MkdirAll(cfg.LogDir, 0755); err != nil {
			log.Fatal().Err(err).Msg("Failed to create log directory")
		}

		// Open log file
		fullPath := filepath.Join(cfg.LogDir, cfg.LogFile)
		file, err := os.OpenFile(fullPath, os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0664)
		if err != nil {
			log.Fatal().Err(err).Msg("Failed to open log file")
		}

		var output io.Writer = file
		env := os.Getenv("APP_ENV")
		if env != "prod" {
			consoleWriter := zerolog.ConsoleWriter{Out: os.Stderr}
			output = zerolog.MultiLevelWriter(consoleWriter, file)
		}

		logger = zerolog.New(output).With().Timestamp().Logger().Level(level)
		logger.Info().Msg("Logger initialized successfully.")
	})
	return logger
}
