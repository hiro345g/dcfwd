package internal.dev.javaapp004;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

/**
 * Main application class for java-app004.
 */
@SpringBootApplication(scanBasePackages = "internal.dev")
@EnableConfigurationProperties(GreetingProperties.class)
public class JavaApp004Application {

  /**
   * Default constructor.
   */
  public JavaApp004Application() {
    // Default constructor
  }

  /**
   * Main entry point for the application.
   *
   * @param args command line arguments.
   */
  public static void main(String[] args) {
    SpringApplication.run(JavaApp004Application.class, args);
  }
}
