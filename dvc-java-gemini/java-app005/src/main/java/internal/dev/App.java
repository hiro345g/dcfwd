package internal.dev;

import internal.dev.javaapp005.GreetingProperties;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

/**
 * The main application class.
 */
@Component
public class App implements CommandLineRunner {

  /** The logger. */
  private static final Logger logger = LoggerFactory.getLogger(App.class);

  private final GreetingProperties greetingProperties;

  /**
   * Constructs the App with GreetingProperties.
   *
   * @param greetingProperties The properties for greeting.
   */
  public App(GreetingProperties greetingProperties) {
    this.greetingProperties = greetingProperties;
  }

  @Override
  public void run(String... args) throws Exception {
    logger.info("This is an info message.");
    logger.warn("This is a warning message.");
    logger.error("This is an error message.");
    logger.info("Greeting message: {}", greetingProperties.getMessage());
  }

  /**
   * Returns a greeting message.
   *
   * @return The greeting from .env file
   */
  public String getGreeting() {
    return greetingProperties.getMessage();
  }
}
