# java-app003

これは、基本的な "Hello, World!" をコンソールに出力するシンプルな Java アプリケーションのための Maven プロジェクトです。SLF4J と Logback によるロギング機能も含んでいます。

## 必要なもの (Prerequisites)

- Java Development Kit (JDK) 21

## 主な依存ライブラリ (Dependencies)

依存ライブラリは `pom.xml` によって管理されます。

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

このプロジェクトを VS Code のワークスペースファイル `java-app003.code-workspace` で開くと、以下の拡張機能のインストールが推奨されます。

- [Extension Pack for Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack)
- [Checkstyle for Java](https://marketplace.visualstudio.com/items?itemName=shengchen.vscode-checkstyle)
- [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-containers)
- その他、Git 関連の便利な拡張機能

## 使い方

### ビルド

プロジェクトをビルドするには、以下のコマンドを実行します。
このコマンドは、依存関係をダウンロードし、Checkstyle でコードスタイルをチェックし、ソースコードをコンパイルします。

```bash
./mvnw clean install
```

### デバッグ

このプロジェクトでは、VS Code の「実行とデバッグ」ビュー (Ctrl+Shift+D または Cmd+Shift+D) を使用して、Java アプリケーションをデバッグできます。

なお、デバッグする際は、ソースコードの一時停止したい行へあらかじめブレイクポイントを設定しておくこと。

#### `Debug (Launch) - App` を使用する

`Debug (Launch) - App` 起動構成は、アプリケーションをビルドしてからデバッグモードで起動します。これは、アプリケーションのコードを変更してすぐにデバッグを開始したい場合に便利です。

1. VS Code の「実行とデバッグ」ビューを開きます。
2. ドロップダウンメニューから「**Debug (Launch) - App**」起動構成を選択します。
3. 緑色の再生ボタンをクリックしてデバッグセッションを開始します。

この構成は、デバッグセッションを開始する前に `maven-build` タスクを実行し、プロジェクトを自動的にビルドします。

#### `Debug (Attach)` について

今回のような単純なコマンドアプリではあまり使用しませんが、常駐型のアプリケーションやリモートマシンで実行するアプリケーションを開発するときに使用することがあります。`Debug (Attach)` 起動構成は、既に実行中の Java アプリケーションにデバッガをアタッチできます。

1. アプリケーションをデバッグモードで起動
2. VS Code でデバッガをアタッチ

アプリケーションをデバッグモードで起動するというのは、JDWP (Java Debug Wire Protocol) エージェントを使ってポート `5005` でデバッガからの接続を待ち受けるように起動するということです。VS Code の `java-app003.code-workspace` のワークスペースを使う場合は、次の手順になります。

1. VS Code の「実行とデバッグ」ビューを開きます。
2. ドロップダウンメニューから「**Launch App - Debug mode**」起動構成を選択します。

アプリケーションがデバッグモードで起動したら、VS Code でデバッガをアタッチできます。

1. VS Code の「実行とデバッグ」ビューを開きます。
2. ドロップダウンメニューから「**Debug (Attach)**」起動構成を選択します。
3. 緑色の再生ボタンをクリックしてデバッグセッションを開始します。

デバッガがアプリケーションにアタッチされると、ブレークポイントの設定、変数の検査、ステップ実行などが可能になります。

ちなみに、アプリケーションをデバッグモードで起動するための設定は `pom.xml` にしてあります。

プロファイルの設定で `debug` プロファイルを用意してあります。そこで次のような JavaVM へ渡すオプションが指定されています。

- `server=y`: アプリケーションがデバッガからの接続を待ち受けるサーバーモードで動作することを示します。
- `suspend=y`: デバッガが接続されるまでアプリケーションの実行を一時停止することを示します。アプリケーションが起動時にデバッガの接続を待たずに実行を継続したい場合は `suspend=y` に設定します。
- `address=5005`: デバッガが接続するポート番号です。全インタフェースにバインドする場合は `address=*:5005"` とします。

「Launch App - Debug mode」起動構成は、このプロファイルの実行を内部的にしています。そのため、VS Code の GUI を使わずにターミナルから起動することもできます。その場合は次のコマンドを実行します。

```bash
./mvnw exec:exec -Pdebug
```

### 実行

アプリケーションを実行するには、以下のコマンドを使用します。

```bash
./mvnw exec:java -Dexec.mainClass="internal.dev.App"
```

実行すると、コンソールに "Hello, World from VS Code!" と表示されます。

### テスト

プロジェクトのテストを実行するには、以下のコマンドを使用します。

```bash
./mvnw test
```

### ドキュメント (Documentation)

このプロジェクトのコードドキュメントは Javadoc を使用しています。
以下のコマンドを実行することで、HTML形式のドキュメントを生成できます。

```bash
./mvnw javadoc:javadoc
```

ドキュメントは `target/site/apidocs` フォルダに出力されます。

### ドキュメントの参照 (Viewing Documentation)

`mvn site` コマンドによって生成されたドキュメント (`target/site` フォルダ以下) を Web ブラウザで参照するには、簡易的な Web サーバーを起動するのが便利です。

#### Java コマンドを使用する場合 (JDK 9 以降)

JDK 9 以降に付属する `SimpleHttpServer` を使用して、`-d` オプションで指定したフォルダをルートとする Web サーバーを起動できます。フォルダの指定には絶対パスを使う必要があります。

```bash
java -m jdk.httpserver -p 8000 -d $(pwd)/target/site
```

開発コンテナ内で起動するときは `-b 0.0.0.0` か `-b ::` を指定して、すべてのインタフェースでバインドすることで Docker ホストの Web ブラウザからアクセスできるようになります。

```bash
java -m jdk.httpserver -b 0.0.0.0 -p 8000 \
  -d /workspaces/dvc-java-gemini/java-app003/target/site
```

サーバーが起動したら、Web ブラウザで <http://localhost:8000/> にアクセスしてください。

#### Node.js の `http-server` を使用する場合

Node.js がインストールされている環境であれば、`http-server` パッケージをインストールして使用できます。

1. `http-server` をグローバルにインストールします (初回のみ)。
2. `target/site` フォルダに移動し、サーバーを起動します。

具体的な実行コマンドは次のようになります。

`http-server` をインストールします。

```bash
npm install -g http-server
```

サーバーを起動します。

```bash
cd target/site
http-server -p 8000
```

サーバーが起動したら、Web ブラウザで <http://localhost:8000/> にアクセスしてください。

### テストレポート (Test Reports)

`./mvnw site` コマンドを実行すると、HTML形式のテストレポートが生成されます。

```bash
./mvnw site
```

レポートは `target/site/surefire-report.html` で確認できます。

## テスト方針 (Testing Policy)

1. フレームワーク: テストは **JUnit 4** を使用して記述します。
2. テストの粒度: 主に単体テスト（ユニットテスト）に焦点を当てます。クラスの public なメソッドの動作を個別に検証します。
3. テストの場所: テストクラス（`...Test.java`）は、`src/test/java` フォルダに配置します。
4. テストの実行: テストは `./mvnw test` を実行して行います。すべてのテストが成功することをもって、変更の完了とします。
5. アサーション: `org.junit.Assert` が提供するメソッド（`assertEquals`, `assertTrue` など）を使用して結果を検証します。

## コーディングスタイル (Coding Style)

このプロジェクトでは、**Google Java Style Guide** をコーディング規約として採用しています。

規約への準拠は [Checkstyle](https://checkstyle.org/) によって自動的にチェックされます。チェックは `./mvnw clean install` を実行するたびに実行されます。

設定ファイル: `google_checks.xml`

## ロギング方針 (Logging Policy)

このプロジェクトでは、ロギングに SLF4J と Logback を使用します。設定は `src/main/resources/logback.xml` にあり、ログはコンソールと `logs/app.log` ファイルに出力されます。

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
java-app003/
├── .mvn/                                # Maven Wrapper の設定ファイル
│   └── wrapper/
│       └── maven-wrapper.properties
├── src/                                 # ソースコードとリソースファイル
│   ├── main/                            # アプリケーションのメインソースコード
│   │   ├── java/                        # Java ソースコード
│   │   │   └── internal/
│   │   │       └── dev/
│   │   │           └── App.java         # メインのアプリケーションクラス
│   │   └── resources/
│   │       └── logback.xml              # Logback の設定ファイル
│   └── test/
│       └── java/
│           └── internal/
│               └── dev/
│                   └── AppTest.java     # App クラスのテストクラス
├── .gitignore                           # Git で無視するファイルを指定
├── google_checks.xml                    # Checkstyle の設定ファイル (Google Java Style)
├── java-app003.code-workspace           # VS Code のワークスペース設定
├── mvnw                                 # Maven Wrapper の実行スクリプト (Linux/macOS)
├── mvnw.cmd                             # Maven Wrapper の実行スクリプト (Windows)
├── pom.xml                              # Maven のプロジェクト設定ファイル
├── GEMINI.md                            # Gemini に関するドキュメント
└── README.md                            # このファイル
```
