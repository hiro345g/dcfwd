# java-app001

これは、基本的な "Hello, World!" をコンソールに出力するシンプルなJavaアプリケーションです。このプロジェクトは、SLF4Jによるロギング機能も含んでいます。

## 使い方

### ビルド

プロジェクトをビルドするには、以下のスクリプトを実行します。
このスクリプトは、依存関係（SLF4J）をダウンロードし、ソースコードをコンパイルします。

```bash
./script/build.sh
```

### 実行

アプリケーションを実行するには、以下のスクリプトを使用します。

```bash
./script/run.sh
```

実行すると、コンソールに "Hello, World from VS Code!" と表示されます。

### テスト

プロジェクトのテストを実行するには、以下のスクリプトを使用します。

```bash
./script/test.sh
```

## プロジェクト構造

```text
java-app001/
├── bin/          # コンパイルされたクラスファイル
├── lib/          # 依存ライブラリ (JARs)
├── script/       # ビルド、実行、テスト用のシェルスクリプト
│   ├── build.sh
│   ├── run.sh
│   └── test.sh
├── src/          # Javaソースコード
│   ├── App.java
│   └── AppTest.java
├── .gitignore
├── java-app001.code-workspace
└── README.md
```
