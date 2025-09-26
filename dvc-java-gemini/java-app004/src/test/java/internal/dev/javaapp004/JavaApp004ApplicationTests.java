package internal.dev.javaapp004;

import static org.junit.jupiter.api.Assertions.assertEquals;

import internal.dev.App;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class JavaApp004ApplicationTests {

  @Autowired
  private App app;

  @Test
  void testGetGreeting() {
    assertEquals("Hello from test-application.properties!", app.getGreeting());
  }

}
