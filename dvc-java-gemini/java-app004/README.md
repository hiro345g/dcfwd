# java-app004

これは、Spring Boot を使用したスタンドアロンの Java コンソールアプリケーションのテンプレートです。`CommandLineRunner` として実行されるように設定されており、コマンドラインベースのタスクに適しています。

## 必要なもの (Prerequisites)

- Java Development Kit (JDK) 21

## 主な依存ライブラリ (Dependencies)

依存ライブラリは `pom.xml` によって管理されます。

| ライブラリ | モジュールとバージョン | 説明 |
| --- | --- | --- |
| **Spring Boot Starter Parent** | `org.springframework.boot:spring-boot-starter-parent` | 依存関係のバージョンを管理します。 |
| **Spring Boot Starter** | `org.springframework.boot:spring-boot-starter` | Spring Boot アプリケーションのコアスターター。 |
| **Spring Boot DevTools** | `org.springframework.boot:spring-boot-devtools` | 開発体験を向上させるためのツール（高速な再起動、LiveReload など）。 |
| **Spring Boot Starter Test** | `org.springframework.boot:spring-boot-starter-test` | JUnit 5, Mockito, Spring Test などを含む、Spring Boot アプリケーションをテストするためのスターター。 |
| **Lombok** | `org.projectlombok:lombok` | ボイラープレートコードを削減するためのライブラリ。 |
| **Checkstyle** | `com.puppycrawl.tools:checkstyle` | Java ソースコードがコーディング規約に準拠しているかをチェックするための静的解析ツール。 |

## 開発環境 (Development Environment)

開発環境の差異をなくすため、VS Code の **Dev Container** を使用することを推奨します。

## 構成 (Configuration)

このプロジェクトでは、Spring Boot のプロファイル機能を利用して、実行環境に応じた設定の切り替えを行っています。設定ファイルは `src/main/resources` ディレクトリにあります。

- **`application.properties`**: すべてのプロファイルで共通して読み込まれる基本設定です。
- **`application-dev.properties`**: `dev` プロファイル（開発用）が有効な場合に読み込まれ、共通設定を上書きします。
- **`application-prod.properties`**: `prod` プロファイル（本番用）が有効な場合に読み込まれ、共通設定を上書きします。

プロファイルは、Maven を実行する際の `-P` オプションで指定します (例: `-P prod`)。指定がない場合のデフォルトは `dev` です。

## ビルド (Build)

プロジェクトのビルドには Maven プロファイルを使用します。これにより、環境に応じた設定でアプリケーションをパッケージ化できます。

また、ここで使用するコマンドを実行すると、依存関係をダウンロードし、Checkstyle でコードスタイルをチェックし、ソースコードをコンパイルして、JAR ファイルにパッケージ化する処理を自動で実行します。

### dev プロファイルでのビルド (デフォルト)

以下のコマンドを実行すると、`dev` プロファイルが有効な状態でアプリケーションがビルドされます。`-P` オプションを指定しない場合、これがデフォルトの動作です。

```bash
./mvnw clean install
```

### prod プロファイルでのビルド

本番環境向けのビルドを行うには、`-P prod` オプションを指定します。

```bash
./mvnw clean install -P prod
```

このコマンドにより、`prod` プロファイルが有効なJARファイルが `target` ディレクトリに生成されます。

## 実行 (Run)

アプリケーションは、Maven プロファイルを使用して、さまざまな構成で実行できます。

### dev プロファイル (デフォルト)

開発用のプロファイルです。`-P` オプションなしで実行した場合、これがデフォルトで有効になります。

```bash
./mvnw spring-boot:run
```

このコマンドは、`dev` Spring Boot プロファイルを有効にしてアプリケーションを起動します。

### prod プロファイル

本番環境用のプロファイルです。以下のコマンドで実行します。

```bash
./mvnw spring-boot:run -P prod
```

このコマンドは、`prod` Spring Boot プロファイルを有効にしてアプリケーションを起動します。

### debug プロファイル

デバッグモードでアプリケーションを起動し、リモートデバッガの接続をポート `5005` で待ち受けます。

```bash
./mvnw spring-boot:run -P debug
```

## デバッグ (Debug)

VS Code の「実行とデバッグ」ビュー (Ctrl+Shift+D または Cmd+Shift+D) を使用して、簡単にアプリケーションを起動・デバッグできます。

### VS Code の起動構成

このワークスペースには、以下の起動構成が定義されています。

- **Run dev profile**: `dev` プロファイルを有効にしてアプリケーションを起動します。
- **Run prod profile**: `prod` プロファイルを有効にしてアプリケーションを起動します。
- **Attach to Remote Debugger**: リモートで実行中のデバッグセッションにアタッチします。

**直接実行:**

1. VS Code の「実行とデバッグ」ビューを開きます。
2. ドロップダウンメニューから `Run dev profile` または `Run prod profile` を選択します。
3. 緑色の再生ボタンをクリックするか、F5キーを押してセッションを開始します。

**リモートデバッグ (アタッチ):**

1. まず、ターミナルで `debug` プロファイルを使用してアプリケーションを起動します（「実行」の「debug プロファイル」を見ること）。
2. アプリケーションがポート `5005` で接続を待ち始めたら、VS Code の「実行とデバッグ」ビューを開きます。
3. ドロップダウンメニューから `Attach to Remote Debugger` を選択します。
4. 緑色の再生ボタンをクリックするか、F5キーを押して、実行中のプロセスにデバッガをアタッチします。

## テスト (Test)

プロジェクトのテストを実行するには、以下のコマンドを使用します。

```bash
./mvnw test
```

## テストレポート (Test Reports)

`./mvnw site` コマンドを実行すると、HTML形式のテストレポートが生成されます。

```bash
./mvnw site
```

レポートは `target/site/surefire-report.html` で確認できます。

## テスト方針 (Testing Policy)

1. **フレームワーク**: テストは **JUnit 5** を使用して記述します (`spring-boot-starter-test` に含まれています)。
2. **テストの粒度**: 主に単体テストと結合テストに焦点を当てます。
3. **テストの場所**: テストクラスは `src/test/java` ディレクトリに配置します。
4. **テストの実行**: テストは `./mvnw test` を実行して行います。すべてのテストが成功することをもって、変更の完了とします。

## コーディングスタイル (Coding Style)

このプロジェクトでは、**Google Java Style Guide** をコーディング規約として採用しています。

規約への準拠は [Checkstyle](https://checkstyle.org/) によって自動的にチェックされます。チェックは `./mvnw clean install` を実行するたびに実行されます。

設定ファイル: `google_checks.xml`

## ロギング方針 (Logging Policy)

このプロジェクトでは、Spring Boot のデフォルトである SLF4J と Logback を使用します。設定は `src/main/resources/logback.xml` にあり、ログはコンソールと `logs/app.log` ファイルに出力されます。

### ログレベル

| レベル | 説明 |
| --- | --- |
| `ERROR` | システムの続行を妨げる致命的なエラー。 |
| `WARN` | 潜在的な問題や、現在はエラーではないが将来的に問題になる可能性のある状況。 |
| `INFO` | システムの正常な動作を示す情報。アプリケーションの起動・終了など。 |
| `DEBUG` | 開発者がデバッグ時にのみ必要とする詳細情報。 |
| `TRACE` | `DEBUG` よりもさらに詳細な情報。 |

## ドキュメント (Documentation)

このプロジェクトのコードドキュメントは Javadoc を使用しています。
以下のコマンドを実行することで、HTML形式のドキュメントを生成できます。

```bash
./mvnw javadoc:javadoc
```

ドキュメントは `target/site/apidocs` フォルダに出力されます。

### ドキュメントの参照 (Viewing Documentation)

`mvn site` コマンドによって生成されたドキュメント (`target/site` フォルダ以下) を Web ブラウザで参照するには、簡易的な Web サーバーを起動するのが便利です。

#### Java コマンドを使用する場合 (JDK 18 以降)

JDK 18 以降に付属する `SimpleFileServer` を使用して、カレントディレクトリをルートとする Web サーバーを起動できます。

```bash
cd target/site
jwebserver -p 8000
```

Dev Container 内で実行する場合は、`-b 0.0.0.0` を指定してすべてのネットワークインターフェースにバインドすることで、ホストマシンのブラウザからアクセスできるようになります。

```bash
cd target/site
jwebserver -b 0.0.0.0 -p 8000
```

サーバーが起動したら、Web ブラウザで <http://localhost:8000/> にアクセスしてください。

## プロジェクト構造

```text
java-app004/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── internal/
│   │   │       └── dev/
│   │   │           ├── App.java
│   │   │           └── javaapp004/
│   │   │               ├── GreetingProperties.java
│   │   │               └── JavaApp004Application.java
│   │   └── resources/
│   │       ├── application.properties
│   │       ├── application-dev.properties
│   │       ├── application-prod.properties
│   │       └── logback.xml
│   └── test/
│       ├── java/
│       │   └── internal/
│       │       └── dev/
│       │           └── javaapp004/
│       │               └── JavaApp004ApplicationTests.java
│       └── resources/
│           └── application.properties
├── .gitignore
├── .sdkmanrc
├── GEMINI.md
├── google_checks.xml
├── java-app004.code-workspace
├── mvnw
├── mvnw.cmd
├── pom.xml
└── README.md
```

## プロジェクトとは別ライセンス (Licenses) のファイル

プロジェクトとは別ライセンス (Licenses) のファイルが含まれています。これらを使用する場合は、それぞれのライセンスに同意してください。使用しない場合は、これらを別の内容に置き換えるか、利用する設定を無効化するようにしてください。

このプロジェクトに含まれる `google_checks.xml` は、[Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0) で配布されている [google_checks.xml](https://github.com/checkstyle/checkstyle/blob/f486dcacb9b6096bd28ce9b6b3d215f922f315e7/src/main/resources/google_checks.xml) のものです。

また、`eclipse-java-google-style.xml` は、CC-By 3.0 License で配布されている [eclipse-java-google-style.xml](https://github.com/google/styleguide/blob/1387bff19c141c047c483cbe813659625f93defa/eclipse-java-google-style.xml) の `<setting id="org.eclipse.jdt.core.formatter.blank_lines_between_import_groups" value="1"/>` に変更したものです。このファイルは [CC-By 3.0 License](https://creativecommons.org/licenses/by/3.0/) で利用可能です。
