package config

import (
	"os"
	"path/filepath"
	"sync"
	"testing"

	"github.com/spf13/viper"
	"github.com/stretchr/testify/assert"
)

// resetSingleton is used to reset the sync.Once and the config instance for testing.
func resetSingleton() {
	once = sync.Once{}
	cfg = nil
	viper.Reset()
}

func TestGetConfig(t *testing.T) {
	t.Run("loads config from file", func(t *testing.T) {
		resetSingleton()
		tempDir := t.TempDir()
		confDir := filepath.Join(tempDir, "conf")
		assert.NoError(t, os.Mkdir(confDir, 0755))
		configPath := filepath.Join(confDir, "config.yaml")
		assert.NoError(t, os.WriteFile(configPath, []byte("level: test_level"), 0644))

		// Temporarily change CWD to tempDir to allow viper to find the conf dir
		originalWD, err := os.Getwd()
		assert.NoError(t, err)
		assert.NoError(t, os.Chdir(tempDir))
		defer func() {
			assert.NoError(t, os.Chdir(originalWD))
		}()

		config := GetConfig()
		assert.Equal(t, "test_level", config.Level)
	})

	t.Run("overrides with environment variables", func(t *testing.T) {
		resetSingleton()
		tempDir := t.TempDir()
		confDir := filepath.Join(tempDir, "conf")
		assert.NoError(t, os.Mkdir(confDir, 0755))
		configPath := filepath.Join(confDir, "config.yaml")
		assert.NoError(t, os.WriteFile(configPath, []byte("level: file_level"), 0644))

		originalWD, err := os.Getwd()
		assert.NoError(t, err)
		assert.NoError(t, os.Chdir(tempDir))
		defer func() {
			assert.NoError(t, os.Chdir(originalWD))
		}()

		t.Setenv("APP_LEVEL", "env_level")

		config := GetConfig()
		assert.Equal(t, "env_level", config.Level)
	})

	t.Run("uses default values when no file is present", func(t *testing.T) {
		resetSingleton()
		tempDir := t.TempDir()

		originalWD, err := os.Getwd()
		assert.NoError(t, err)
		assert.NoError(t, os.Chdir(tempDir))
		defer func() {
			assert.NoError(t, os.Chdir(originalWD))
		}()

		config := GetConfig()
		assert.Equal(t, "info", config.Level) // Default level is info
	})

	t.Run("is a singleton", func(t *testing.T) {
		resetSingleton()
		tempDir := t.TempDir()
		originalWD, err := os.Getwd()
		assert.NoError(t, err)
		assert.NoError(t, os.Chdir(tempDir))
		defer func() {
			assert.NoError(t, os.Chdir(originalWD))
		}()

		// Get the config instance twice
		config1 := GetConfig()
		config2 := GetConfig()

		// Check that they are the same instance
		assert.Same(t, config1, config2)
	})
}