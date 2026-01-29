# WildFly 開発コンテナのサンプル

このプロジェクトは、[WildFly](https://www.wildfly.org/) アプリケーションを開発するための開発コンテナー環境のサンプルを提供するものです。

## 概要

この開発コンテナを使うと、 WildFly のインストール、アプリケーションのビルド、デプロイ、およびサーバーの起動・停止ができるようになります。

VS Code と Dev Containers 拡張機能を使用することで、依存関係のインストールや環境設定の手間をかけずに、すぐに開発を始めることができます。

また、[Gradle](https://gradle.org/) と [CodeHaus Cargo](https://codehaus-cargo.github.io/) プラグインを使用して、WildFly の管理が Gradle タスクを通じて行えるプロジェクトのサンプルも含みます。

以下、`${PROJECT_DIR}` は、wildfly-202601 のパスとします。開発コンテナでは `/workspaces/wildfly-202601` となります。

## 前提条件

- [Docker](https://www.docker.com/)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) 拡張機能

## はじめ方

次の手順で開発コンテナを起動して VS Code から使えるようにします。

1. 開発コンテナ用イメージのプル
2. VS Code でこのファイルを含むフォルダを開きます。
3. `F1` キーを押してコマンドパレットを開き、「**Dev Containers: Reopen in Container**」を実行します。

最初に JDK が使えるようになっている開発コンテナ用イメージ `hiro345g/dvc:jdk-202601` を `docker` コマンドでプルしておきます。イメージがない場合は、手順 2. で自動でプルされますが、イメージのサイズが大きいことから、ここの処理が長くかかるため、事前に実行しておくのが良いからです。

```bash
docker image pull hiro345g/dvc:jdk-202601
```

後は、手順通りにします。これにより、開発コンテナーがビルドされ、プロジェクトがコンテナー内で開かれます。開かれた VS Code の画面で作業ができるようになっています。

## プロジェクトのファイル構成

wildfly-202601 プロジェクトのファイル構成は次のとおりです。

```text
wildfly-202601/
├── .devcontainer/ 開発コンテナー用フォルダ
│   ├── compose.yaml ... Docker サービスの定義ファイル
│   └── devcontainer.json ... 開発コンテナーの設定ファイル
├── .gitignore
├── README.md
├── wildfly/compose.yaml ... wildfly コンテナ用
├── wildfly-app001/build.gradle ... wildfly を利用するプロジェクト用 Gradle ファイル
└── wildfly-app001/settings.gradle ... Gradle 用設定ファイル
```

`.devcontainer` フォルダにある `devcontainer.json` は、開発コンテナーの設定ファイルです。使用する Docker Compose サービスや VS Code 拡張機能を定義します。

同じフォルダにある `compose.yaml` は、開発コンテナーとして使用する Docker サービスの定義ファイルです。

`wildfly/compose.yaml` は、スタンドアロンの WildFly サービスを起動するための Docker Compose ファイルです。このサービスを使用して `Wildfly` の実行ファイルを入手します。開発コンテナーとは直接関係ありません。

`wildfly-app001` フォルダにある `build.gradle` は、`Wildfly` を使用する Java プロジェクト用のビルドスクリプトです。依存関係、 Cargo プラグインの設定、およびカスタム Gradle タスクが定義されています。同じフォルダにある `settings.gradle` は  Gradle 用設定ファイルです。中身はありませんが、ファイルが存在している必要がるので用意してあります。

## 開発コンテナー内のツール

開発コンテナーイメージ (`hiro345g/dvc:jdk-202601`) には、開発に便利な以下のツールが含まれています。

- JDK
- Gradle
- mise
- SDKMAN!

## Gradle Cargo 2026 プラグインのサンプルプロジェクト

`wildfly-app001` に Gradle Cargo 2026 プラグインを使うためのサンプル `build.gradle` が用意されています。

コンテナー内のターミナルで以下の Gradle タスクを実行できます。なお、実行するときのカレントは `wildfly-app001` とします。

開発コンテナ wildfly-202601 を使っている場合は次のようにしてカレントを `${PROJECT_DIR}/wildfly-app001` にします。

```bash
cd /workspaces/wildfly-202601/wildfly-app001
```

提供される主な Gradle タスクについて簡単に説明します。

| タスク            | 説明                                   |
| ----------------- | -------------------------------------- |
| `installWildFly`  | WildFly のインストール                 |
| `gradle assemble` | アプリケーションのビルド               |
| `cargoRunLocal`   | WildFly サーバーの起動                 |
| `cargoStartLocal` | WildFly サーバーのバックグラウンド起動 |
| `cargoStopLocal`  | WildFly サーバーの停止                 |

`installWildFly` は、`build.gradle` で定義されたバージョンの WildFly をダウンロードし、 `build/wildfly-home` ディレクトリに展開します。

```bash
gradle installWildFly
```

`gradle assemble` は、`src/main/webapp` にあるソースコードを `war` ファイルにパッケージングします。ここではサンプルアプリを用意していないので、動作するアプリは用意されませんが、実行することはできます。

```bash
gradle assemble
```

`cargoRunLocal` は、WildFly サーバーをフォアグラウンドで起動し、コンソールにログを直接出力します。

```bash
gradle cargoRunLocal
```

起動した `Wildfly` の動作を確認するには、別ターミナルを開いて `curl` コマンドで <http://localhost:8080/> へアクセスします。実行例は次のようになります。

```bash
$ curl -I -4 -v http://localhost:8080/
* Host localhost:8080 was resolved.
* IPv6: ::1
* IPv4: 127.0.0.1
*   Trying 127.0.0.1:8080...
* Connected to localhost (127.0.0.1) port 8080
> HEAD / HTTP/1.1
> Host: localhost:8080
> User-Agent: curl/8.5.0
> Accept: */*
> 
< HTTP/1.1 200 OK
HTTP/1.1 200 OK
< Connection: keep-alive
Connection: keep-alive
（略）
< 
* Connection #0 to host localhost left intact
```

動作確認ができたら、`WildFly` を起動したターミナルで `Ctrl + C` を入力（Ctrl と C のキーを同時に押下）してログの出力を停止します。`CodeHaus Cargo` で同じように `Tomcat` を使う場合は、これでサーバーが停止するのですが、`Wildfly` の場合は追加で、`pkill` コマンドでサーバーを停止させる必要がありました。

まず、`ps` コマンドと `grep` コマンドでプロセスが停止していないことを確認しておきます。

```bash
ps ax | grep [w]ildfly
```

実行例は次のようになります。

```bash
$ ps ax|grep [w]ildfly
15768 ?        Sl     0:15 /usr/l（略） --server-config=standalone.xml
```

`pkill` コマンドで停止します。

```bash
pkill -f wildfly
```

`ps ax | grep [w]ildfly` を再度実行すると、該当するプロセスが存在しなくなったことがわかり、`Wildfly` が停止したことが確認できます。

WildFly サーバーをバックグラウンドで起動したい場合は `cargoStartLocal` を使います。アプリケーションは <http://localhost:8080/> でアクセス可能になります。このタスクは `installWildFly` と `assemble` に依存していて、これらの実行も含みます。

```bash
gradle cargoStartLocal
```

`cargoStopLocal` は、バックグラウンドで実行中の WildFly サーバーを停止します。

```bash
gradle cargoStopLocal
```

このプロジェクトで使われている `build.gradle` のコードを参考にすることで、実際の Gradle プロジェクトで `Wildfly` のインストールから削除まで管理できるようになります。

## Wildfly コンテナ用 Docker サンプルプロジェクト

`wildfly` に Wildfly コンテナ用のサンプルである `compose.yaml` ファイルが用意されています。

開発コンテナ wildfly-202601 を使っている場合は次のようにして `wildfly` サービスを起動します。

```bash
cd /workspaces/wildfly-202601/wildfly
docker compose up -d
```

これで、`Wildfly` の実行ファイルを `wildfly` サーバ椅子用の `wildfly` コンテナからコピーできるようになります。

`docker compose cp` で `WildFly` の本体をコピーし、終わったらコンテナを破棄します。

```bash
docker compose -p wildfly cp wildfly:/opt/jboss/wildfly ./wildfly31-jdk17
docker compose down
```

これで `Wildfly` の実行に必要なファイルが `${PROJECT_DIR}/wildfly/wildfly31-jdk17` に用意できます。

ここで、注意点があります。`wildfly31-jdk17` に含まれる `standalone/configuration/logging.properties` ファイルに、次のようにコピー元のコンテナ内のパスが使われているものがあります。使う前にこれを直しておく必要があります。

```ini
handler.FILE.fileName=/opt/jboss/wildfly/standalone/log/server.log
```

開発コンテナの場合は、次のように `sed` コマンドを使って置換できます。エディタで手で直しても良いです。

```bash
cd /workspaces/wildfly-202601/wildfly/wildfly31-jdk17
export JBOSS_HOME=$(pwd)
sed -i "s%/opt/jboss/wildfly%${JBOSS_HOME}%" \
    ${JBOSS_HOME}/standalone/configuration/logging.properties
```

コピーした `wildfly31-jdk17` を使うには、ここでは JDK 17 用の Wildfly 31.0.1 の Docker イメージを使っているので、Java 17の実行環境が必要です。

開発コンテナを使っている場合は `/workspaces/wildfly-202601/wildfly/wildfly31` となります。これを使って `Wildfliy` が使えるようになります。

試しに `Wildfly` に含まれる `jboss-cli.sh` を開発コンテナで実行する場合は次のようにします。

```bash
cd /workspaces/wildfly-202601/wildfly/wildfly31-jdk17
JAVA_HOME=/usr/local/sdkman/candidates/java/17.0.17-tem ./bin/jboss-cli.sh help
```

これで、`jboss-cli.sh` のヘルプが表示されます。

ちなみに JDK 25 を使うとエラーになります。

```bash
$ JAVA_HOME=/usr/local/sdkman/candidates/java/25.0.1-tem ./bin/jboss-cli.sh help
Exception in thread "main" java.lang.UnsupportedOperationException: Setting a system-wide Policy object is not supported
        at java.base/java.security.Policy.setPolicy(Policy.java:114)
        at org.jboss.modules.Main.main(Main.java:395)
```

実際に `Wildfly` を起動するには、`jboss.home.dir` などのプロパティを調整する必要があります。開発コンテナなら、次のコマンドで起動できます。

```bash
JAVA_HOME=/usr/local/sdkman/candidates/java/17.0.17-tem ./bin/standalone.sh \
  -Djboss.home.dir=$(pwd) \
  -Djboss.server.base.dir=$(pwd)/standalone \
  -b 0.0.0.0
```

停止するには、起動したターミナルへ `Ctrl + C` を入力します。または、別ターミナルで `jboss-cli.sh` を使って、シャットダウンのコマンドを実行します。

```bash
JAVA_HOME=/usr/local/sdkman/candidates/java/17.0.17-tem \
  ./bin/jboss-cli.sh --connect command=shutdown
```

`JBOSS_HOME` という環境変数を指定すると、`jboss.home.dir` といったプロパティをコマンドのパラメータに指定する必要がなくなります。開発コンテナで `JAVA_HOME` と `JBOSS_HOME` を指定して `Wildfly` を起動するコマンドは次のようになります。

```bash
cd /workspaces/wildfly-202601/wildfly/wildfly31-jdk17
echo $JAVA_HOME
export JAVA_HOME=/usr/local/sdkman/candidates/java/17.0.17-tem
export JBOSS_HOME=$(pwd)
./bin/standalone.sh
```

実行例は次のとおり。確認のため、途中で `echo` コマンドを実行しています。

```bash
$ cd /workspaces/wildfly-202601/wildfly/wildfly31-jdk17
$ echo $JAVA_HOME
/usr/local/sdkman/candidates/java/current
$ echo $JBOSS_HOME

$ export JAVA_HOME=/usr/local/sdkman/candidates/java/17.0.17-tem
$ export JBOSS_HOME=$(pwd)
/workspaces/wildfly-202601/wildfly/wildfly31-jdk17
$ echo $JAVA_HOME
/usr/local/sdkman/candidates/java/17.0.17-tem
$ echo $JBOSS_HOME
$ ./bin/standalone.sh
=========================================================================

  JBoss Bootstrap Environment

  JBOSS_HOME: /workspaces/wildfly-202601/wildfly/wildfly31-jdk17

  JAVA: /usr/local/sdkman/candidates/java/17.0.17-tem/bin/java

（略）
```

なお、環境変数を設定した場合は、作業終了時に戻しておくと良いでしょう。

```bash
export JAVA_HOME=/usr/local/sdkman/candidates/java/current
export JBOSS_HOME=
```

使用する Java、Wildfly のバージョンについて間違いがないようにするには Docker を使うのが確実です。DB を利用するような開発では Docker を導入していることも多いでしょう。Docker 環境がある場合に、ネイティブな Wildfly 環境が必要な場合は、このようにして用意するというのは一つの選択肢としてありだと考えています。

## Wildfly 公式の Getting Started

この開発コンテナでは、Wildfly 公式の Getting Started を試すこともできます。`Maven` を利用しているプロジェクトや、とにかくすぐに `WildFly` で動くサンプルアプリケーションを手に入れたい場合に最適です。

この方法だと、`Maven` でアプリケーションの雛形を作ると同時に、その実行に必要な `WildFly` サーバーも `target` ディレクトリ内に自動で構築（プロビジョニング）してくれます。

### プロジェクトの生成

ここではあらかじめ作成してありますが、自分で用意するときは、`mvn archetype:generate` を実行します。

なお、ここで用意されているものは、開発コンテナ内のプロジェクトルート (`/workspaces/wildfly-202601`) で、`mvn archetype:generate` を実行したものです。

具体的には次のコマンドを実行時して作成しました。

```bash
cd /worksapces/wildfly-20261
mvn -B archetype:generate \
    -DarchetypeGroupId=org.wildfly.archetype \
    -DarchetypeArtifactId=wildfly-getting-started-archetype
```

これで `getting-started` が作成されます。使用するには、ターミナルのカレントを `getting-started` にします。開発コンテナでは次のコマンドを実行します。

```bash
cd /workspaces/wildfly-202601/getting-started
```

### ビルドとサーバー起動

生成されたディレクトリで `mvn package` を実行すると、サーバーが `target/server` に構築され、`standalone.sh` で起動できるようになります。

```bash
cd getting-started/
mvn package verify
```

`Wildfly` のバージョンを確認しておきます。

```bash
cat pom.xml | grep "<version.wildfly.bom>"
```

記事執筆時点では `38.0.1.Final` でした。

```bash
$ cat pom.xml | grep "<version.wildfly.bom>"
        <version.wildfly.bom>38.0.1.Final</version.wildfly.bom>
```

起動するには次のコマンドを実行します。

```bash
./target/server/bin/standalone.sh
```

開発コンテナ wildfly-202601 を使った場合の実行例は、次のとおりです。環境変数の `JAVA_HOME` や `JBOSS_HOME` が指定されていると警告が表示されることがあります。

```bash
$ ./target/server/bin/standalone.sh
=========================================================================

  JBoss Bootstrap Environment

  JBOSS_HOME: /workspaces/wildfly-202601/getting-started/target/server

  JAVA: /usr/local/sdkman/candidates/java/17.0.17-tem/bin/java
```

`Ctrl + C` で起動したスクリプトを停止できます。普通にインストールした `Wildfly` の場合は `jboss-cli.sh` が含まれていますが、こちらにはありません。

とはいえ、`jboss-cli.sh` 実行に必要なファイルをコピーして持ってくれば使えます。開発コンテナ wildfly-202601 では、Wildfly 38.0.1.Final は、`wildfly-app001/build.gradle` を使ってインストールできます。そこでインストールした `Wildfly`  がある場合は、別ターミナルで次のように実行します。

```bash
cp ../wildfly-app001/build/wildfly-home/bin/jboss-cli* ./target/server/bin/
./target/server/bin/jboss-cli.sh --connect command=shutdown
```

このように、Getting Started では、開発作業に特化した `Wildfly` の環境が用意されるようです。Gradle より Maven に慣れていて、余計なツールは不要で、とにかく Wildfly のアプリを動かせる開発環境が欲しいときに良さそうです。例えば、Jakarta EE アプリの学習で Maven を使っている場合などに適していそうです。
