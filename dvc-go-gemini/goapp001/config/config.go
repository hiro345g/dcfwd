package config

import (
	"strings"
	"sync"

	"github.com/rs/zerolog/log"
	"github.com/spf13/viper"
)

// Config holds all configuration for the application.
type Config struct {
	Level   string `mapstructure:"level"`
	LogDir  string `mapstructure:"logdir"`
	LogFile string `mapstructure:"logfile"`
}

var (
	cfg  *Config
	once sync.Once
)

// GetConfig returns the singleton config instance.
// It initializes the config on the first call.
func GetConfig() *Config {
	once.Do(func() {
		loadConfig()
	})
	return cfg
}

// loadConfig reads configuration from file and environment variables.
func loadConfig() {
	v := viper.New()

	// Set default values
	v.SetDefault("level", "info")
	v.SetDefault("logdir", "log")
	v.SetDefault("logfile", "app.log")

	// Load from config file
	v.SetConfigName("config")
	v.AddConfigPath("conf")
	v.SetConfigType("yaml")
	if err := v.ReadInConfig(); err != nil {
		if _, ok := err.(viper.ConfigFileNotFoundError); ok {
			log.Info().Msg("No config file found, using default and environment variable settings.")
		} else {
			log.Fatal().Err(err).Msg("Failed to read config file")
		}
	}

	// Load from environment variables
	v.SetEnvPrefix("APP")
	v.SetEnvKeyReplacer(strings.NewReplacer(".", "_"))
	v.AutomaticEnv()

	// Unmarshal config
	if err := v.Unmarshal(&cfg); err != nil {
		log.Fatal().Err(err).Msg("Failed to unmarshal config")
	}

	log.Info().Msgf("Configuration loaded successfully. Log level: %s", cfg.Level)
}
