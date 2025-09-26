package internal.dev.javaapp005;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Configuration properties for greeting messages.
 */
@ConfigurationProperties(prefix = "greeting")
public class GreetingProperties {

  private String message;

  /**
   * Default constructor.
   */
  public GreetingProperties() {
    // Default constructor
  }

  /**
   * Gets the greeting message.
   *
   * @return The greeting message.
   */
  public String getMessage() {
    return message;
  }

  /**
   * Sets the greeting message.
   *
   * @param message The greeting message to set.
   */
  public void setMessage(String message) {
    this.message = message;
  }
}
