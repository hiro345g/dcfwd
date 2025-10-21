# java-app002

これは、基本的な "Hello, World!" をコンソールに出力するシンプルな Java アプリケーションです。このプロジェクトは、SLF4J と Logback によるロギング機能も含んでいます。

## クイックスタート (Quick Start)

```bash
# プロジェクトをビルドする
./gradlew build

# アプリケーションを実行する
./gradlew run

# テストを実行する
./gradlew test
```

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

## ビルド

プロジェクトをビルドするには、以下のコマンドを実行します。
このコマンドは、依存関係をダウンロードし、Checkstyle でコードスタイルをチェックし、ソースコードをコンパイルします。

```bash
./gradlew build
```

## デバッグ

このプロジェクトでは、VS Code の「実行とデバッグ」ビュー (Ctrl+Shift+D または Cmd+Shift+D) を使用して、Java アプリケーションをデバッグできます。

なお、デバッグする際は、ソースコードの一時停止したい行へあらかじめブレイクポイントを設定しておくこと。

### `Debug (Launch) - App` を使用する

`Debug (Launch) - App` 起動構成は、アプリケーションをビルドしてからデバッグモードで起動します。これは、アプリケーションのコードを変更してすぐにデバッグを開始したい場合に便利です。

1. VS Code の「実行とデバッグ」ビューを開きます。
2. ドロップダウンメニューから「**Debug (Launch) - App**」起動構成を選択します。
3. 緑色の再生ボタンをクリックしてデバッグセッションを開始します。

この構成は、デバッグセッションを開始する前に `gradle-build` タスクを実行し、プロジェクトを自動的にビルドします。

### `Debug (Attach)` について

今回のような単純なコマンドアプリではあまり使用しませんが、常駐型のアプリケーションやリモートマシンで実行するアプリケーションを開発するときに使用することがあります。`Debug (Attach)` 起動構成は、既に実行中の Java アプリケーションにデバッガをアタッチできます。

1. アプリケーションをデバッグモードで起動
2. VS Code でデバッガをアタッチ

アプリケーションをデバッグモードで起動するというのは、JDWP (Java Debug Wire Protocol) エージェントを使ってポート `5005` でデバッガからの接続を待ち受けるように起動するということです。

ターミナルからアプリケーションをデバッグモードで起動することもできます。その場合は次のコマンドを実行します。

```bash
./gradlew run --debug-jvm
```

アプリケーションがデバッグモードで起動したら、VS Code でデバッガをアタッチできます。

1. VS Code の「実行とデバッグ」ビューを開きます。
2. ドロップダウンメニューから「**Debug (Attach)**」起動構成を選択します。
3. 緑色の再生ボタンをクリックしてデバッグセッションを開始します。

デバッガがアプリケーションにアタッチされると、ブレークポイントの設定、変数の検査、ステップ実行などが可能になります。

## 実行

アプリケーションを実行するには、以下のコマンドを使用します。

```bash
./gradlew run
```

実行すると、コンソールに "Hello, World from VS Code!" と表示されます。

## テスト

プロジェクトのテストを実行するには、以下のコマンドを使用します。

```bash
./gradlew test
```

テスト結果はコンソールに詳しく表示されます。

**注意:** ソースコードに変更がない場合、Gradle はテストの実行をスキップすることがあります (結果が `UP-TO-DATE` と表示されます)。その場合でもテストを強制的に再実行するには、以下のコマンドを使用してください。

```bash
./gradlew cleanTest test
```

なお、`./gradlew test` を実行すると、`app/build/reports/tests/test` フォルダに HTML 形式のテストレポートが出力されます。
このレポートをブラウザで確認するには、Web サーバーを起動するのが便利です。

## ドキュメント (Documentation)

このプロジェクトのコードドキュメントは Javadoc を使用しています。
以下のコマンドを実行することで、HTML形式のドキュメントを生成できます。

```bash
./gradlew javadoc
```

ドキュメントは `app/build/docs/javadoc` フォルダに出力されます。参照する際に簡易 Web サーバーを起動するのが便利です。

## 簡易 Web サーバー

ドキュメントやレポートの参照時に使う簡易 Web サーバーについて説明します。

### JDK 9 以降に付属する `SimpleHttpServer` を使用する場合

JDK 9 以降に付属する `SimpleHttpServer` を使用して、`-d` オプションで指定したフォルダをルートとする Web サーバーを起動できます。フォルダの指定には絶対パスを使う必要があります。

生成されたテストのレポート (`app/build/reports/tests/test` フォルダ以下) を参照する場合は次のコマンドとなります。

```bash
# プロジェクトのルートディレクトリで実行
java -m jdk.httpserver -p 8000 -d $(pwd)/app/build/reports/tests/test
```

生成されたドキュメント (`app/build/docs/javadoc` フォルダ以下) を参照する場合は次のコマンドとなります。

```bash
# プロジェクトのルートディレクトリで実行
java -m jdk.httpserver -p 8000 -d $(pwd)/app/build/docs/javadoc
```

開発コンテナ内で起動するときは `-b 0.0.0.0` か `-b ::` を指定して、すべてのインタフェースでバインドすることで Docker ホストの Web ブラウザからアクセスできるようになります。

生成されたテストのレポート (`app/build/reports/tests/test` フォルダ以下) を参照する場合は次のコマンドとなります。

```bash
# プロジェクトのルートディレクトリで実行
java -m jdk.httpserver -b 0.0.0.0 -p 8000 \
  -d $(pwd)/app/build/reports/tests/test
```

生成されたテストのレポート (`app/build/docs/javadoc` フォルダ以下) を参照する場合は次のコマンドとなります。

```bash
# プロジェクトのルートディレクトリで実行
java -m jdk.httpserver -b 0.0.0.0 -p 8000 \
  -d $(pwd)/app/build/docs/javadoc
```

サーバーが起動したら、Web ブラウザで <http://localhost:8000/> にアクセスしてください。

### Node.js の `http-server` を使用する場合

Node.js がインストールされている環境であれば、`http-server` パッケージをインストールして使用できます。

1. `http-server` をグローバルにインストールします (初回のみ)。
2. ドキュメントルートとするフォルダに移動し、サーバーを起動します。

具体的な実行コマンドは次のようになります。

`http-server` をインストールします。

```bash
npm install -g http-server
```

ドキュメントルートとするフォルダに移動。テストレポートの場合は次のコマンドとなります。

```bash
cd app/build/reports/tests/test
```

Java API ドキュメントの場合は次のコマンドとなります。

```bash
cd app/build/docs/javadoc
```

サーバーを起動します。

```bash
http-server -p 8000
```

サーバーが起動したら、Web ブラウザで <http://localhost:8000/> にアクセスしてください。

## 開発ポリシー

### コーディングスタイル (Coding Style)

このプロジェクトでは、**Google Java Style Guide** をコーディング規約として採用しています。

規約への準拠は [Checkstyle](https://checkstyle.org/) によって自動的にチェックされます。チェックは `./gradlew build` を実行するたびに実行されます。

設定ファイル: `google_checks.xml`

### テスト方針 (Testing Policy)

1. フレームワーク: テストは **JUnit 4** を使用して記述します。
2. テストの粒度: 主に単体テスト（ユニットテスト）に焦点を当てます。クラスの public なメソッドの動作を個別に検証します。
3. テストの場所: テストクラス（`...Test.java`）は、`app/src/test/java` フォルダに配置します。
4. テストの実行: テストは `./gradlew test` を実行して行います。すべてのテストが成功することをもって、変更の完了とします。
5. アサーション: `org.junit.Assert` が提供するメソッド（`assertEquals`, `assertTrue` など）を使用して結果を検証します。

### ロギング方針 (Logging Policy)

このプロジェクトでは、ロギングに SLF4J と Logback を使用します。設定は `app/src/main/resources/logback.xml` にあり、ログはコンソールと `logs/app.log` ファイルに出力されます。

**ログレベル**:

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
├── GEMINI.md                            # Gemini に関するドキュメント
├── README.md                            # このファイル
├── .gitattributes                       # Git の属性ファイル
├── .gitignore                           # Git で無視するファイルを指定
├── app/
│   ├── build.gradle                     # app モジュールのビルドスクリプト
│   ├── logs/
│   │   └── app.log
│   └── src/
│       ├── main/
│       │   ├── java/
│       │   │   └── internal/
│       │   │       └── dev/
│       │   │           └── App.java     # メインのアプリケーションクラス
│       │   └── resources/
│       │       └── logback.xml          # Logback の設定ファイル
│       └── test/
│           ├── java/
│           │   └── internal/
│           │       └── dev/
│           │           └── AppTest.java # App クラスのテストクラス
│           └── resources/
├── google_checks.xml                    # Checkstyle の設定ファイル (Google Java Style)
├── gradle/
│   ├── libs.versions.toml               # 依存ライブラリのバージョンカタログ
│   └── wrapper/
│       ├── gradle-wrapper.jar           # Gradle Wrapper の JAR ファイル
│       └── gradle-wrapper.properties    # Gradle Wrapper の設定
├── gradle.properties                    # Gradle のプロパティ設定
├── gradlew                              # Gradle Wrapper の実行スクリプト (Linux/macOS)
├── gradlew.bat                          # Gradle Wrapper の実行スクリプト (Windows)
├── java-app002.code-workspace           # VS Code のワークスペース設定
└── settings.gradle                      # プロジェクトのモジュール設定
```

## プロジェクトとは別ライセンス (Licenses) のファイル

プロジェクトとは別ライセンス (Licenses) のファイルが含まれています。これらを使用する場合は、それぞれのライセンスに同意してください。使用しない場合は、これらを別の内容に置き換えるか、利用する設定を無効化するようにしてください。

このプロジェクトに含まれる `google_checks.xml` は、[Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0) で配布されている [google_checks.xml](https://github.com/checkstyle/checkstyle/blob/f486dcacb9b6096bd28ce9b6b3d215f922f315e7/src/main/resources/google_checks.xml) のものです。
