# dvc-mise

このプロジェクトは、<https://mise.jdx.dev/> で公開されている `mise-en-place` の `mise` コマンドを使えるようにした開発コンテナのサンプルです。`mise` コマンドを使うと、色々なプログラミング言語のための開発環境を手軽に用意することができます。

各プログラミング言語向けに用意された専用の開発ツールの方が機能面で有利であったり、実際のプロジェクトで採用されていたりしますが、自分があまり慣れていないプログラミング言語の初歩的なコードを記述したい場合に、`mise` を使えるようにしておくと何かと便利です。

最近だと、よく使用する `npx` や `uvx` のようなコマンドのバージョン管理をすることもできるので、ローカルの開発マシンでは常に使えるようにしています。

このプロジェクトでは、開発コンテナを用意して、`mise` の動作確認や機能調査ができるようにしてあります。また、主要なプログラミング言語の簡単なサンプルプロジェクトを用意して、実際に `mise` を使うときに、どのように使用するか試すことができるようにしてあります。

## プロジェクト構成

次のフォルダは各プログラミング言語用のサンプルプロジェクトです。

| コード       | 説明    |
| :----------- | :------ |
| `goapp001`   | Go      |
| `javaapp001` | Java    |
| `nodeapp001` | Node.js |
| `phpapp001`  | PHP     |
| `pyapp001`   | Python  |
| `rubyapp001` | Ruby    |

これ以降、この `README.md` ファイルを含むフォルダを `${PROJECT_DIR}` と表記することにします。

コマンドを実行するときは、ターミナルで `cd` コマンドを使って `${PROJECT_DIR}` をカレントにすること。

```bash
cd ${PROJECT_DIR}
```

## `mise.toml`

このリポジリのルートにある `mise.toml` ファイルは、さまざまな言語ランタイムとツールに必要なバージョンを定義するために使用されます。これにより、すべてのプロジェクトで一貫した開発環境を保証できます。

## 開発コンテナの利用の準備

### イメージのビルド

このプロジェクトを利用するには、まず開発コンテナイメージをビルドする必要があります。`build-base-image` ディレクトリにある `build.sh` スクリプトを使用してビルドすることができます。

```bash
bash ./build-base-image/build.sh
```

少し時間がかかりますから、気長に待ちましょう。また、内部的に Ruby や PHP をソースコードからビルドするため、高負荷になります。16GB メモリを搭載した CPU が i5 の Ubuntu Desktop マシンでも、VS Code や Chrome を起動しながらビルドするとメモリ不足でプロセスが落ちてしまうことがありました。その場合は、ビルド対象外とするために、`mise.toml` の `ruby` と `php` の行頭に `##` をつけて（`##ruby` や `##php` のようにする）からビルドします。

### .gemini フォルダの用意

開発コンテナでは Gemini CLI をインストールして使えるようにしてあります。その設定用フォルダは Docker ホストマシンで用意する設定となっているので、用意します。

Gemini CLI を使っている場合は `~/.gemini` フォルダがあるはずなので、それをコピーします。使っていない場合は空の `.gemini` フォルダを作成します。そのためのスクリプト `init.sh` を用意してあるので、次のように実行します。

```bash
bash ./script/init.sh
```

## 開発コンテナの利用方法

ここでは開発コンテナの利用方法について説明します。

### 開発コンテナの起動と利用

イメージをビルドと `.gemini` フォルダを用意したら、次のコマンドで開発コンテナを起動できます。

```bash
cd dvc-mise
code .
```

VS Code が起動したら、「コンテナーで再度開く」という通知が表示されるのでボタンをクリックします。すると、dvc-mise の開発コンテナをアタッチした VS Code の画面が表示されます。その画面でターミナルを開いて `mise` コマンドを使った作業ができます。

### 開発コンテナが使用するボリュームについて

開発コンテナが使用するボリュームについては、`.devcontainer/compose.yaml` を参照するとわかります。下記のものがあります。

- dvc-mise の Docker Compose プロジェクト用フォルダを `/workspaces/dvc-mise` にバインドマウント
- Gemini 設定用フォルダをバインドマウント `/home/vscode/.gemini` にバインドマウント
- mise 用フォルダを Docker ボリューム `dvc-mise-share-mise` へマウント
- mise trust の情報を保存するフォルダを Docker ボリューム `dvc-mise-state-mise` へマウント

使用しているボリュームを初期化したい場合は削除してから開発コンテナを起動します。そのためのスクリプト `clean.sh` を用意してあります。

実際にボリュームを削除するには開発コンテナを停止しておく必要があり、次のようにコマンドを実行すると良いでしょう。

```bash
docker compose -p dvc-mise down
bash ./script/clean.sh
```

### 開発コンテナの終了

一時的に作業を止める場合は VS Code の画面を閉じてから `dvc-mise` の Docker Compose プロジェクトを停止します。

```bash
docker compose -p dvc-mise stop
```

開発コンテナをアタッチした VS Code の画面を閉じてから `dvc-mise` の Docker Compose プロジェクトを削除します。

```bash
docker compose -p dvc-mise down
```

## 開発コンテナで mise を利用

この開発コンテナを起動したら、`mise` コマンドを使って各サンプルプロジェクトのコードを実行できます。

## goapp001 プロジェクト

`goapp001` アプリケーションを実行するには、`/workspaces/dvc-mise/goapp001` で `mise` コマンドが使えるように `mise trust` を実行します（最初のときだけ必要）。それから、`task` コマンドが使えるようにインストールします（最初のときだけ必要）。

具体的なコマンドは次のようになります。

```bash
cd /workspaces/dvc-mise/goapp001
mise trust
go install github.com/go-task/task/v3/cmd/task@latest
```

それから、`task` コマンドを実行します。`start` タスクは `Taskfile.yml` に定義してあります。

```bash
task start
```

アプリケーションを実行すると `Hello, world!` と表示されます。

実行例

```bash
$ task start
task: [start] go run main.go
Hello, world!
```

## javaapp001 プロジェクト

`javaapp001` アプリケーションを実行するには、開発コンテナ内で以下のコマンドを実行します。

```bash
cd /workspaces/dvc-mise/javaapp001
./gradlew run
```

アプリケーションを実行すると `Hello World!` と表示されます。

実行例

```bash
$ ./gradlew run
（略）
Starting a Gradle Daemon (subsequent builds will be faster)
Calculating task graph as no cached configuration is available for tasks: run

> Task :app:run
Hello World!

BUILD SUCCESSFUL in 32s
2 actionable tasks: 2 executed
Configuration cache entry stored.
```

## nodeapp001 プロジェクト

`nodeapp001` アプリケーションを実行するには、開発コンテナ内で以下のコマンドを実行します。

```bash
cd /workspaces/dvc-mise/nodeapp001
npm start
```

アプリケーションを実行すると `Hello, world!` と表示されます。

実行例

```bash
$ npm start

> nodeapp001@1.0.0 start
> node index.js

Hello, world!
```

## phpapp001 プロジェクト

`phpapp001` アプリケーションを実行するには、開発コンテナ内で以下のコマンドを実行します。

```bash
cd /workspaces/dvc-mise/phpapp001
composer install
composer run start
```

アプリケーションを実行すると `Hello, PHP Console App!` と表示されます。

実行例

```bash
$ composer install
Installing dependencies from lock file (including require-dev)
Verifying lock file contents can be installed on current platform.
Nothing to install, update or remove
Generating autoload files
$ composer run start
> php main.php
Hello, PHP Console App!
```

## pyapp001 プロジェクト

`goapp001` アプリケーションを実行するには、`/workspaces/dvc-mise/pyapp001` で `mise` コマンドが使えるように `mise trust` を実行します（最初のときだけ必要）。

具体的なコマンドは次のようになります。

```bash
cd /workspaces/dvc-mise/pyapp001
mise trust
```

アプリケーションを実行するには `mise run` を使います。`start` タスクは `mise.toml` に定義してあります。

```bash
mise run start
```

`mise run start` は、仮想環境を初期化し（既に存在する場合はスキップ）、仮想環境をアクティブにしてから、アプリを実行します。なお、`mise.toml` に指定されている `uv` コマンドがインストールされていない場合は、インストールします。

アプリケーションを実行すると `Hello, world!` と表示されます。

実行例

```bash
$ mise run start

[init] $ [ -d .venv ] || uv venv
[start] $ . .venv/bin/activate && python main.py
Hello, world!
Finished in 23.9ms
```

## rubyapp001 プロジェクト

`rubyapp001` アプリケーションを実行するには、開発コンテナ内で以下のコマンドを実行します。

```bash
cd /workspaces/dvc-mise/rubyapp001
bundle install
bundle exec ruby main.rb
```

アプリケーションを実行すると `Hello, world!` と表示されます。

実行例

```bash
$ bundle install
Bundle complete! 1 Gemfile dependency, 1 gem now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
$ bundle exec ruby main.rb
Hello, world!
```
