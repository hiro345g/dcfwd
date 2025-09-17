package internal.dev;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * The main application class.
 */
public class App {

  /** The logger. */
  private static final Logger logger = LoggerFactory.getLogger(App.class);

  /**
   * Returns a greeting message and logs some messages.
   *
   * @return The greeting "Hello, World from VS Code!"
   */
  public static String getGreeting() {
    logger.info("This is an info message.");
    logger.warn("This is a warning message.");
    logger.error("This is an error message.");
    return "Hello, World from VS Code!";
  }

  /**
   * The main entry point of the program.
   *
   * @param args The command line arguments (not used).
   * @throws Exception If an exception occurs.
   */
  public static void main(String[] args) throws Exception {
    System.out.println(getGreeting());
  }
}
