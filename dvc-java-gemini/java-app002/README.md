# java-app002

これは、基本的な "Hello, World!" をコンソールに出力するシンプルな Java アプリケーションです。このプロジェクトは、SLF4J と Logback によるロギング機能も含んでいます。

## 必要なもの (Prerequisites)

- Java Development Kit (JDK) 21

## 主な依存ライブラリ (Dependencies)

依存ライブラリは `app/build.gradle` と `gradle/libs.versions.toml` によって管理されます。

| ライブラリ    | モジュールとバージョン                     | 説明                                                                                                       |
|---------------|--------------------------------------------|------------------------------------------------------------------------------------------------------------|
| Checkstyle    | `com.puppycrawl.tools:checkstyle:10.17.0`  | Java ソースコードがコーディング規約に準拠しているかをチェックするための静的解析ツール。                    |
| Guava         | `com.google.guava:guava:33.4.5-jre`        | Google のコア Java ライブラリ。コレクション、キャッシング、プリミティブサポートなど。                      |
| SLF4J API     | `org.slf4j:slf4j-api:2.0.17`               | 各種ロギングフレームワーク（Logback など）のシンプルなファサード。                                         |
| Logback       | `ch.qos.logback:logback-classic:1.5.6`     | SLF4J のネイティブ実装であり、Log4j の後継として広く使われている高パフォーマンスなロギングフレームワーク。 |
| JUnit         | `junit:junit:4.13.2`                       | Java アプリケーションのユニットテストを記述・実行するためのフレームワーク。                                |
| Hamcrest Core | `org.hamcrest:hamcrest-core:1.3`           | `assertThat`構文を使い、より宣言的で可読性の高いアサーション（テストの検証文）を記述するためのライブラリ。 |

## 開発環境 (Development Environment)

開発環境の差異をなくすため、VS Code の **Dev Container** を使用することを推奨します。

### VS Code 拡張機能

このプロジェクトを VS Code のワークスペースファイル `java-app002.code-workspace` で開くと、以下の拡張機能のインストールが推奨されます。

- [Extension Pack for Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack)
- [Checkstyle for Java](https://marketplace.visualstudio.com/items?itemName=shengchen.vscode-checkstyle)
- [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-containers)
- その他、Git 関連の便利な拡張機能

## 使い方

### ビルド

プロジェクトをビルドするには、以下のコマンドを実行します。
このコマンドは、依存関係をダウンロードし、Checkstyle でコードスタイルをチェックし、ソースコードをコンパイルします。

```bash
./gradlew build
```

### 実行

アプリケーションを実行するには、以下のコマンドを使用します。

```bash
./gradlew run
```

実行すると、コンソールに "Hello, World from VS Code!" と表示されます。

### テスト

プロジェクトのテストを実行するには、以下のコマンドを使用します。

```bash
./gradlew test
```

## テスト方針 (Testing Policy)

1. フレームワーク: テストは **JUnit 4** を使用して記述します。
2. テストの粒度: 主に単体テスト（ユニットテスト）に焦点を当てます。クラスの public なメソッドの動作を個別に検証します。
3. テストの場所: テストクラス（`...Test.java`）は、`app/src/test/java` フォルダに配置します。
4. テストの実行: テストは `./gradlew test` を実行して行います。すべてのテストが成功することをもって、変更の完了とします。
5. アサーション: `org.junit.Assert` が提供するメソッド（`assertEquals`, `assertTrue` など）を使用して結果を検証します。

## コーディングスタイル (Coding Style)

このプロジェクトでは、**Google Java Style Guide** をコーディング規約として採用しています。

規約への準拠は [Checkstyle](https://checkstyle.org/) によって自動的にチェックされます。チェックは `./gradlew build` を実行するたびに実行されます。

設定ファイル: `google_checks.xml`

## ロギング方針 (Logging Policy)

このプロジェクトでは、ロギングに SLF4J と Logback を使用します。設定は `app/src/main/resources/logback.xml` にあり、ログはコンソールと `logs/app.log` ファイルに出力されます。

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
java-app002/
├── app/
│   ├── build.gradle
│   └── src/
│       ├── main/
│       │   ├── java/
│       │   │   └── internal/
│       │   │       └── dev/
│       │   │           └── App.java
│       │   └── resources/
│       │       └── logback.xml
│       └── test/
│           └── java/
│               └── internal/
│                   └── dev/
│                       └── AppTest.java
├── gradle/
│   ├── libs.versions.toml
│   └── wrapper/
│       ├── gradle-wrapper.jar
│       └── gradle-wrapper.properties
├── logs/
│   └── .gitkeep
├── .gitignore
├── google_checks.xml
├── gradlew
├── gradlew.bat
├── java-app002.code-workspace
├── README.md
└── settings.gradle
```

## プロジェクトとは別ライセンス (Licenses) のファイル

プロジェクトとは別ライセンス (Licenses) のファイルが含まれています。これらを使用する場合は、それぞれのライセンスに同意してください。使用しない場合は、これらを別の内容に置き換えるか、利用する設定を無効化するようにしてください。

このプロジェクトに含まれる `google_checks.xml` は、[Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0) で配布されている [google_checks.xml](https://github.com/checkstyle/checkstyle/blob/f486dcacb9b6096bd28ce9b6b3d215f922f315e7/src/main/resources/google_checks.xml) のものです。
