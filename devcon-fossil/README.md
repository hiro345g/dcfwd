# devcon-fossil

　これは、バージョン管理システムの [Fossil](https://fossil-scm.org/) を試してみるときに使用した開発コンテナー関連のファイルです。一般ユーザーの node （ユーザーID 1000、グループ ID 1000）で実行します。

　dev-fossil の開発コンテナーを使ってみたときに不便だと感じていた点を解消しています。

　以降、このファイルがあるディレクトリーを `${REPO_DIR}` と表記します。

## 動作環境

- Docker Engine
  - Docker Compose Plugin
- VS Code
  - Docker 拡張機能
  - Dev Containers 拡張機能

## ディレクトリー構造

```text
devcon-fossil/
├── .devcontainer/
│   ├── devcontainer.json
│   └── script/ ... devcon-fossil 開発コンテナー内で使えるスクリプト
│       ├── postCreateCommand-node.sh ... 開発コンテナー作成後に node ユーザーで実行するスクリプト
│       └── postCreateCommand.sh ... 開発コンテナー作成後に root ユーザーで実行するスクリプト
├── README.md ... このファイル
├── docker-compose.yml ... devcon-fossil 開発コンテナー用 Docker Compose 設定ファイル
└── script/ ... Docker ホストで使用するスクリプト
    └── fossil-clean.sh
```

## devcon-fossil コンテナーの起動

1. VS Code の「ファイル」-「フォルダーを開く」で `${REPO_DIR}` を開く
2. 右下に表示される通知で「開発コンテナーで再度開く」をクリック
3. 左下に `開発コンテナー:devcon-fossil` と表示された開発コンテナーが開く

　これ以降、開発コンテナーの VS Code は `devcon-fossil の VS Code` と表記します。

## サンプルリポジトリ

　開発コンテナー起動時に、`/home/node/repo/proj001.fossil` というサンプルリポジトリのファイルを自動で作成するようにしてあります。

## SQLTools

　fossil のリポジトリファイルの実体は SQLite の DB です。SQLTools の拡張機能を使うことで、VS Code から利用できるようになります。この開発コンテナーでは最初から使えるようにしています。

## devcon-fossil-home-node-repo-data ボリューム

　この開発コンテナー用の `docker-compose.yml` では、devcon-fossil-home-node-repo-data ボリュームを用意していて、`devcon-fossil:/home/node/repo` を永続化しています。そのため、開発コンテナーを破棄しても、ここに作成したリポジトリは残っています。

## devcon-fossil 開発コンテナーのクリーニング

　devcon-fossil 開発コンテナーのクリーニングをするには、次のように Docker ホストで `fossil-clean.sh` スクリプトを実行します。シェルスクリプトが実行できない OS を Docker ホストで使っている場合は、相当する処理を手作業で実行してください。基本的にスクリプト内にある `docker` コマンドの部分を実行すれば大丈夫です。なお、クリーニングしても良い状態にしてから、実行するようにしてください。

```console
cd ${REPO_DIR}
sh script/fossil-clean.sh
```

　このスクリプトは、devcon-fossil 開発コンテナーが使っていた Docker ボリュームと Docker ネットワークといったリソースについて、完全に破棄します。実行すると、開発コンテナーを破棄してから、Docker ボリュームと Docker ネットワークも破棄します。
