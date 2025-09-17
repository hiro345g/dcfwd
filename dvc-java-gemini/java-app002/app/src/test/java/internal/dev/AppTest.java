package internal.dev;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

/**
 * Test class for the App class.
 */
public class AppTest {

  /**
   * Tests the getGreeting method.
   */
  @Test
  public void testGetGreeting() {
    assertEquals("Hello, World from VS Code!", App.getGreeting());
  }
}
