import static org.junit.Assert.assertEquals;

import org.junit.Test;

/**
 * App クラスのテストクラス.
 */
public class AppTest {
  /**
   * getGreeting メソッドのテスト.
   * 戻り値が期待通りのメッセージであることを検証します。
   */
  @Test
  public void testGetGreeting() {
    // App.getGreeting()を呼び出し、戻り値が期待通りか検証
    assertEquals("Hello, World from VS Code!", App.getGreeting());
  }
}
