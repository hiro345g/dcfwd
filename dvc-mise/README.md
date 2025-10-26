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

## dvc-mise 利用に必要な条件

お使いの PC に VS Code がインストールされている必要があります。

- [Visual Studio Code](https://code.visualstudio.com/)

また、次の `VS Code` 拡張機能もインストールしておいてください。

- [Container Tools](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-containers)
- [Docker DX](https://marketplace.com/items?itemName=docker.docker)
- [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

Linux、macOS では `git` が必要です。

Windows の場合は、次のツールが必要です。

- [Git for Windows](https://gitforwindows.org/)
- [WSL Ubuntu](https://learn.microsoft.com/ja-jp/windows/wsl/install)

Windows では PowerShell を管理者モードで起動して、次のコマンドを実行すると、これらをインストールできます。

```ps1
winget install -e --id Git.Git
wsl --install
```

### Docker

Dockerのソフトウェアも必要です。

- `Docker`
  - [Docker Engine](https://docs.docker.com/engine/)
  - [Docker Compose](https://docs.docker.com/compose/)

**Linux**:

Docker Compose は Docker Engine に含まれているので、Linux では、<https://docs.docker.com/engine/install/> にある手順に従ってインストールします。

**macOS**:

Lima (<https://github.com/lima-vm/lima>) などをインストールした環境を用意して Docker Engine や Docker Compose をインストールします。

ライセンスについて注意が必要ですが、[Docker Desktop](https://docs.docker.com/desktop/) をインストールしても良いです。Docker Desktop のライセンスについては、<https://docs.docker.com/subscription/desktop-license/> を確認してください。個人利用であれば無償ですが、そうでない場合は、商用ライセンスが必要となる場合があります。

**Windows**:

`WSL Ubuntu` をインストールしてあれば、開発コンテナを使うときにこれらを含む `Docker in WSL` が自動でインストールされます。そのため、前提条件としては必須ではありません。なお、`Docker in WSL` は `WSL Ubuntu` へ Docker の公式リポジトリを登録して、`docker-ce` パッケージ等をインストールするものです。

ここで、`Docker in WSL` だと `WSL Ubuntu` 内でしか `docker` コマンドが使えません。

macOS と同様にライセンスについて注意が必要ですが、[Docker Desktop](https://docs.docker.com/desktop/) を `Docker in WSL` の代わりにインストールしても良いです。こちらであれば、Windows の PowerShell や Git Bash でも `docker` コマンドが使えます。

Windows で `Docker Desktop` をインストールするには、PowerShell を管理者モードで起動して、次のコマンドを実行するとインストールできます。

```ps1
winget install -e --id Docker.DockerDesktop
```

::::message

通常は `Docker Desktop` をインストールするか、自分で `Docker in WSL` をインストールすることが多いでしょうから、`Docker in WSL` の自動インストールについては資料がすくないかと思います。筆者も詳細は調べていないため、環境によってはうまく動作しないことがあるかもしれません。ということで、参考になりそうな関連ファイルの情報を、ここに示しておきます。

WSL Ubuntu の `wsl.conf` では `systemd` を有効化してあります。

```bash
$ cat /etc/wsl.conf

[boot]
systemd=true
```

VS Code のユーザー設定については `%APPDATA%\Code\User\settings.json` に設定ファイルがあり、Docker in WSL がインストールされた後の内容は次のようになっていました。

```bash
$ cat /mnt/c/Users/user001/AppData/Roaming/Code/User/settings.json
{
    "dev.containers.executeInWSL": true,
}
```

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

イメージをビルドと `.gemini` フォルダを用意したら、開発コンテナの起動して使ってみましょう。

VS Codeを起動し、「ファイル」メニューから「フォルダを開く...」を選択して、先ほど用意した `dvc-mise` フォルダを開きます。

もしくはターミナルで次のコマンドを実行します。

```bash
cd $PROJECT_DIR
code .
```

フォルダを開いた VS Code の画面が表示されると、VS Code の右下に「フォルダーには開発コンテナー構成ファイルが含まれています。コンテナーで再度開きますか？」という通知が表示されます。「コンテナーで再度開く」ボタンをクリックしてください。

もし通知が表示されない場合は、`F1` キー（または `Ctrl+Shift+P`）でコマンドパレットを開き、`Dev Containers: Reopen in Container` と入力して実行します。

これだけで、`dvc-mise` 用に設定されたDockerコンテナが起動し、その中で VS Code が再起動します。VS Code の左下が「開発コンテナー: dvc-mise」のようになれば成功です。

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
