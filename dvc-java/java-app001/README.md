# java-app001

これは、基本的な "Hello, World!" をコンソールに出力するシンプルな Java アプリケーションです。このプロジェクトは、SLF4J と Logback によるロギング機能も含んでいます。

## 必要なもの (Prerequisites)

- Java Development Kit (JDK) 21

## 主な依存ライブラリ (Dependencies)

依存ライブラリは `script/build.sh` によって `lib/` フォルダにダウンロードされます。

| ライブラリ    | バージョン | 説明                                                                                                       |
| ------------- | ---------- | ---------------------------------------------------------------------------------------------------------- |
| Checkstyle    | `10.17.0`  | Java ソースコードがコーディング規約に準拠しているかをチェックするための静的解析ツール。                    |
| SLF4J API     | `2.0.17`   | 各種ロギングフレームワーク（Logback など）のシンプルなファサード。                                         |
| Logback       | `1.5.6`    | SLF4J のネイティブ実装であり、Log4j の後継として広く使われている高パフォーマンスなロギングフレームワーク。 |
| JUnit         | `4.13.2`   | Java アプリケーションのユニットテストを記述・実行するためのフレームワーク。                                |
| Hamcrest Core | `1.3`      | `assertThat`構文を使い、より宣言的で可読性の高いアサーション（テストの検証文）を記述するためのライブラリ。 |

## 開発環境 (Development Environment)

開発環境の差異をなくすため、VS Code の **Dev Container** を使用することを推奨します。

### VS Code 拡張機能

このプロジェクトを VS Code で開くと、`java-app001.code-workspace`ファイルに基づき、以下の拡張機能のインストールが推奨されます。

- [Extension Pack for Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack)
- [Checkstyle for Java](https://marketplace.visualstudio.com/items?itemName=shengchen.vscode-checkstyle)
- [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-containers)
- その他、Git 関連の便利な拡張機能

## 使い方

### ビルド

プロジェクトをビルドするには、以下のスクリプトを実行します。
このスクリプトは、依存関係をダウンロードし、Checkstyle でコードスタイルをチェックし、ソースコードをコンパイルします。

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

プロジェクトのテストを実行するには、以下のスクリプトを使用します。このスクリプトは、まずプロジェクト全体のビルド（依存関係の解決、スタイルチェック、コンパイル）を実行し、その後 JUnit テストを実行します。

```bash
./script/test.sh
```

## テスト方針 (Testing Policy)

1. フレームワーク: テストは **JUnit 4** を使用して記述します。
2. テストの粒度: 主に単体テスト（ユニットテスト）に焦点を当てます。クラスの public なメソッドの動作を個別に検証します。
3. テストの場所: テストクラス（`...Test.java`）は、テスト対象のクラスと同じ `src` フォルダに配置します。
4. テストの実行: テストは `bash script/test.sh` を実行して行います。すべてのテストが成功することをもって、変更の完了とします。
5. アサーション: `org.junit.Assert` が提供するメソッド（`assertEquals`, `assertTrue` など）を使用して結果を検証します。

## コーディングスタイル (Coding Style)

このプロジェクトでは、**Google Java Style Guide** をコーディング規約として採用しています。

規約への準拠は [Checkstyle](https://checkstyle.org/) によって自動的にチェックされます。チェックはビルドスクリプトに組み込まれており、`./script/build.sh` を実行するたびに実行されます。

設定ファイル: `google_checks.xml`

## ロギング方針 (Logging Policy)

このプロジェクトでは、ロギングに SLF4J と Logback を使用します。設定は `src/logback.xml` にあり、ログはコンソールと `logs/app.log` ファイルに出力されます。

### ログレベル

以下の基準でログレベルを使い分けます。

| レベル  | 説明                                                                       |
| ------- | -------------------------------------------------------------------------- |
| `ERROR` | システムの続行を妨げる致命的なエラー。                                     |
| `WARN`  | 潜在的な問題や、現在はエラーではないが将来的に問題になる可能性のある状況。 |
| `INFO`  | システムの正常な動作を示す情報。アプリケーションの起動・終了など。         |
| `DEBUG` | 開発者がデバッグ時にのみ必要とする詳細情報。                               |
| `TRACE` | `DEBUG` よりもさらに詳細な情報。                                           |

## プロジェクト構造

```text
java-app001/
├── bin/          # コンパイルされたクラスファイル
├── lib/          # 依存ライブラリ (JARs)
├── logs/         # ログファイル
├── script/       # ビルド、実行、テスト用のシェルスクリプト
│   ├── build.sh
│   ├── run.sh
│   └── test.sh
├── src/          # Javaソースコード
│   ├── App.java
│   ├── AppTest.java
│   └── logback.xml
├── .gitignore
├── google_checks.xml
├── java-app001.code-workspace
└── README.md
```
