# webapp001

このドキュメントは `webapp001` プロジェクトの開発方法について説明します。

`Gradle Cargo 2026 Plugin` を利用して、Tomcat サーバーのダウンロード、起動、デプロイ、デバッグを Gradle タスクで管理します。

## セットアップ

開発を始めるには、開発コンテナを使用する方法と、ローカルのネイティブ環境を使用する方法があります。

### 開発コンテナを使用する場合

VS Code と開発コンテナ (Dev Containers) を利用するのが最も簡単で推奨される方法です。

1. このリポジトリを VS Code で開きます。
2. コマンドパレット (`Ctrl+Shift+P` または `Cmd+Shift+P`) を開き、「**Dev Containers: Reopen in Container**」を実行します。
3. 開発コンテナが起動したら、VS Code のターミナルで以下のコマンドを実行して、プロジェクトで指定された Java のバージョンを有効にします。

```bash
sdk env
```

`.sdkmanrc` ファイルに記述された JDK がインストールされていない場合は、自動的にダウンロード・インストールされます。

これで開発環境の準備は完了です。

### ネイティブ環境で開発する場合

開発コンテナを使用しない場合は、次の手順で環境を手動セットアップする必要があります。

1. Java のインストール
2. IDE 設定ファイルの生成
3. 設定ファイルの修正
4. 不要なディレクトリの削除

最初に Java をインストールします。

このプロジェクトでは `.sdkmanrc` ファイルで Java のバージョンを指定しています。`SDKMAN!` を使って必要な JDK をインストールしてください。

```bash
# プロジェクトで必要な JDK をインストール・有効化
sdk env install
sdk env
```

次に、VS Code の Java 拡張機能や Eclipse IDE でプロジェクトを正しく認識させるために、以下のコマンドを実行して設定ファイルを生成します。

```bash
./gradlew eclipse --no-configuration-cache
./gradlew eclipseWtp --no-configuration-cache
```

生成されたファイルの一部は、最新の Web アプリケーション開発環境に合わせて手動で修正する必要があります。

```bash
sed -i 's%facet="jst.web" version="2.4"%facet="jst.web" version="6.0"%' .settings/org.eclipse.wst.common.project.facet.core.xml
sed -i 's%source-path="src/main/java"%source-path="build/classes/java/main"%' .settings/org.eclipse.wst.common.component
sed -i 's%<classpathentry kind="output" path="bin/default"/>%<classpathentry kind="output" path="build/default"/>%' .classpath
sed -i 's%<classpathentry output="bin/main" kind="src" path="src/main/java">%<classpathentry output="build/classes/java/main" kind="src" path="src/main/java">%' .classpath
```

`eclipse` タスクを実行した際に `bin` ディレクトリが作成された場合は、削除してください。

```bash
rm -fr bin
```

## 基本的な使い方

### Tomcat の起動と停止

**起動**:

以下のコマンドを実行すると、Tomcat のダウンロードと設定が自動的に行われ、アプリケーションがバックグラウンドで起動します。

```bash
./gradlew start
```

**停止**:

起動した Tomcat を停止するには、以下のコマンドを実行します。

```bash
./gradlew stop
```

### ログの確認

Tomcat のインストール先は `./build/tomcat-home` です。

Tomcat のログは以下の場所で確認できます。

| パス                                  | 説明                       |
| ------------------------------------- | -------------------------- |
| `./build/tomcat-home/logs/server.log` | Tomcat 自体のログ          |
| `/tmp/cargo/conf/logs/*.txt`          | Web アプリへのアクセスログ |

### 動作確認

Web ブラウザや `curl` コマンドで、次の URL へアクセスすることで、Web アプリの動作確認ができます。

| URL                         | 説明                             |
| --------------------------- | -------------------------------- |
| <http://localhost:8080/>    | トップページ (`index.jsp`)       |
| <http://localhost:8080/app> | サーブレット (`ServletApp.java`) |

サーバーが起動したら、Web ブラウザで <http://localhost:8080> にアクセスしてください。`index.jsp` の内容が表示されます。

```text
Hello JSP!

Apache Tomcat/10.1.49

    java.vm.name: OpenJDK 64-Bit Server VM
    java.vm.vendor: Eclipse Adoptium
    java.vm.version: 17.0.17+8
```

ターミナルから `curl` を使って確認することもできます。

```bash
$ curl -L -v http://localhost:8080/
*   Trying 127.0.0.1:8080...
* Connected to localhost (127.0.0.1) port 8080
> GET / HTTP/1.1
> Host: localhost:8080
> User-Agent: curl/8.5.0
> Accept: */*
>
< HTTP/1.1 200
< Set-Cookie: JSESSIONID=...; Path=/; HttpOnly
< Content-Type: text/html;charset=UTF-8
< Content-Length: 213
< Date: ...
<
<html>
<body>
<p>Hello JSP!</p>
<p>Apache Tomcat/10.1.49</p>
<ul>
    <li>java.vm.name: OpenJDK 64-Bit Server VM</li>
    <li>java.vm.vendor: Eclipse Adoptium</li>
    <li>java.vm.version: 17.0.17-tem</li>
</ul>
</body>
</html>
```

<http://localhost:8080/app> にアクセスすると、`ServletApp.java` プログラムの実行結果が表示されます。

```bash
$ curl -L -v http://localhost:8080/app
*   Trying 127.0.0.1:8080...
* Connected to localhost (127.0.0.1) port 8080
> GET /app HTTP/1.1
> Host: localhost:8080
> User-Agent: curl/8.5.0
> Accept: */*
>
< HTTP/1.1 200
< Content-Type: text/html;charset=utf-8
< Content-Length: 78
< Date: ...
<
<html><body>
<p>Hello, webapp001</p>
Apache Tomcat/10.1.49
</body></html>
```

## 開発ワークフロー

### アプリの再デプロイ (ホットデプロイ)

ソースコード（Java や JSP ファイル）を修正した後、サーバーを再起動せずに変更を反映させたい場合は、以下のコマンドを実行します。

```bash
./gradlew cargoRedeployLocal
```

このコマンドは、アプリケーションを再ビルドし、稼働中の Tomcat に再デプロイします。

### アプリのデバッグ

1. デバッグモードで Tomcat を起動
2. VS Code でデバッガーをアタッチ
3. デバッグの実行
4. デバッグの終了

デバッグを行うには、まず Tomcat をデバッグモードで起動します。デバッガーはポート `5005` で接続を待ち受けます。

```bash
./gradlew start-debug
```

デバッグしたい Java ファイル (例: `src/main/java/internal/dev/ServletApp.java`) を開き、行番号の左側をクリックしてブレークポイントを設定します。

VS Code の「実行とデバッグ」ビューを開きます。

デバッグ構成のドロップダウンから「**Debug**」を選択し、再生ボタン (▶️) をクリックします。

デバッガーがアタッチされた状態で、ブレークポイントを設定したコードが実行される URL (例: <http://localhost:8080/app>) にアクセスします。

ブレークポイントで実行が一時停止し、変数の確認やステップ実行が可能になります。

デバッグを終わらせるには、VS Code のデバッグツールバーで「切断」をクリックします。

それから、次のコマンドで Tomcat を停止します。

```bash
./gradlew stop-debug
```
