/**
 * メインクラス
 */
public class App {
    /**
     * 挨拶用の固定メッセージを返します。
     * @return "Hello, World from VS Code!" という文字列
     */
    public static String getGreeting() {
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