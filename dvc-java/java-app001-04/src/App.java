import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * メインクラス
 */
public class App {
    /** ロガー */
    private static final Logger logger = LoggerFactory.getLogger(App.class);

    /**
     * 挨拶用の固定メッセージを返し、その過程でログを出力します。
     * @return "Hello, World from VS Code!" という文字列
     */
    public static String getGreeting() {
        logger.info("This is an info message.");
        logger.warn("This is a warning message.");
        logger.error("This is an error message.");
        return "Hello, World from VS Code!";
    }

    /**
     * プログラムのエントリーポイント。
     * getGreeting() メソッドで取得したメッセージを標準出力に出力します。
     * @param args コマンドライン引数（未使用）
     * @throws Exception 例外が発生した場合
     */
    public static void main(String[] args) throws Exception {
        System.out.println(getGreeting());
    }
}