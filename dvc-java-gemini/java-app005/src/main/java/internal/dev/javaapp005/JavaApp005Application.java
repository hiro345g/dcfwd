package internal.dev.javaapp005;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

/**
 * Main application class for java-app005.
 */
@SpringBootApplication(scanBasePackages = "internal.dev")
@EnableConfigurationProperties(GreetingProperties.class)
public class JavaApp005Application {

  /**
   * Default constructor.
   */
  public JavaApp005Application() {
    // Default constructor
  }

  /**
   * Main entry point for the application.
   *
   * @param args command line arguments.
   */
  public static void main(String[] args) {
    SpringApplication.run(JavaApp005Application.class, args);
  }
}
