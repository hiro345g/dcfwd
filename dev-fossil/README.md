# dev-fossil

　これは、バージョン管理システムの [Fossil](https://fossil-scm.org/) を試してみるときに使用した開発コンテナー関連のファイルです。root 権限で実行するので Docker のボリュームについて、バインドマウントを使わないようにしています。

　以降、このファイルがあるディレクトリーを `${REPO_DIR}` と表記します。

## 動作環境

- Docker Engine
  - Docker Compose Plugin
- VS Code
  - Docker 拡張機能
  - Dev Containers 拡張機能

## ディレクトリー構造

```text
dev-fossil/
├── README.md ... このファイル
├── devcontainer-script/ ... dev-fossil 開発コンテナー内で使えるスクリプト
│   ├── install-fossil.sh
│   └── useradd-node.sh
├── docker-compose.yml ... dev-fossil 開発コンテナー用 Docker Compose 設定ファイル
└── script/ ... Docker ホストで使用するスクリプト
    ├── copy_to_c.sh
    ├── copy_to_h.sh
    └── fossil-clean.sh
```

## dev-fossil コンテナーの起動

1. VS Code のエクスプローラーで `${REPO_DIR}/docker-compose.yml` を右クリック
2. メニューの `Compose Up` をクリック
3. VS Code の Docker で CONTAINERS にある dev-fossil - ubuntu:22.04 を右クリック
4. メニューの `Visual Studio Code をアタッチ` をクリック
5. 開発コンテナーをアタッチした VS Code（左下に `コンテナー ubuntu:22.04(ubuntu2204)` と表示されているもの）で `/root/` フォルダーを開く

　これ以降、開発コンテナーの VS Code は `dev-fossil の VS Code` と表記します。

## dev-fossil コンテナーを使って fossil インストール

　次の手順で dev-fossil コンテナーを使って fossil インストールができる `install-fossil.sh` を dev-fossil コンテナー内に用意して、dev-fossil コンテナーのターミナルを開きます。

1. Docker ホストの VS Code で `${REPO_DIR}/devcontainer-script/install-fossil.sh` を右クリック
2. dev-fossil の VS Code のエクスプローラーで右クリック
3. メニューにある `貼り付け` をクリックして `install-fossil.sh` を dev-fossil 開発コンテナーへコピー
4. dev-fossil の VS Code のエクスプローラーに貼り付けられた `install-fossil.sh` を右クリック
5. メニューにある `統合ターミナル` をクリックして dev-fossil の VS Code のターミナルを表示

　準備ができたら dev-fossil 開発コンテナーの `install-fossil.sh` を実行します。手順に従っていれば、dev-fossil の VS Code のターミナルは `install-fossil.sh` があるディレクトリーがカレントディレクトリーとなっているので、下記コマンドで実行できます。

```console
sh ./install-fossil.sh
```

　インストールができたら、`fossil` コマンドをインストールした `${HOME}/.local/bin` を環境変数 PATH へ追加します。ここでは、`install-fossil.sh` を `.` コマンドで読み込めば良いです。

```console
. ./install-fossil.sh
```

　これで `fossil` コマンドが使えるようになります。動作確認には `fossil version` というコマンド実行をしてバージョンを表示してみると良いでしょう。

　実行するコマンドについてまとめると次のようになります。バージョン表示の実行例も含めてあります。

```console
root@ubuntu2204:~# sh ./install-fossil.sh
（略）
root@ubuntu2204:~# . install-fossil.sh 
root@ubuntu2204:~# fossil version
This is fossil version 2.23 [47362306a7] 2023-11-01 18:56:47 UTC
```

　これで、root ユーザーを使うことになりますが、`fossil` コマンドを使って色々と試すことができるようになります。

　なお、ターミナルを新しく用意した場合は、環境変数 PATH には `${HOME}/.local/bin` が含まれていないので、`. install-fossil.sh` を実行する必要があります。注意してください。

## node ユーザーの利用

　Linux について詳しい人なら、dev-fossil 開発コンテナーをアタッチする VS Code は root ユーザーにアタッチしている環境だという前提で、一般ユーザーを追加して調査をするといったことができます。

　ただし、あまり使い勝手は良くないので、個人的には割り切って root ユーザーを使って試しています。

　その場合は、`${REPO_DIR}/devcontainer-script/useradd-node.sh` にあるスクリプトを dev-fossil 開発コンテナー内で実行して node ユーザーを追加して使ってください。スクリプトの次の内容の1行なので、これを実行しても良いです。

```console
useradd -m node -s /bin/bash
```

　それから `su` コマンドでユーザーを変えます。

```console
su - node
```

## dev-fossil-ubuntu2204-root-dir-data ボリューム

　この開発コンテナー用の `docker-compose.yml` では、dev-fossil-ubuntu2204-root-dir-data ボリュームを用意していて、`ubuntu2204:/root` を永続化しています。そのため、開発コンテナーを破棄してもインストールした `fossil` コマンドは残っています。

## ファイルコピー用スクリプト

　自分は実際に dev-fossil コンテナーを使って、`fossil` をインストールする `install-fossil.sh` を作成しました。このインストールスクリプトを作成するときは、ファイルのバックアップも兼ねながら、開発コンテナーと Docker ホスト間とでファイルコピーを何度かしました。その時に使ったスクリプトを `${REPO_DIR}/script/copy_to_*.sh` に置いてあります。これらは Docker ホストで実行するものです。

　VS Code を使えば GUI でコピーができますが、何度か繰り返すような作業はスクリプトで用意しておくと便利です。内容的には次のような単純なものですが、サンプルとしても使えるものなので入れてあります。

```sh: copy_to_h.sh
# Docker ホストへコピー
d=$(cd $(dirname $0)/../devcontainer-script;pwd)
docker compose -p dev-fossil cp ubuntu2004:/root/install-fossil.sh ${d}/
```

```sh: copy_to_c.sh
# dev-fossil 開発コンテナーへコピー
d=$(cd $(dirname $0)/../devcontainer-script;pwd)
docker compose -p dev-fossil cp ${d}/install-fossil.sh ubuntu2004:/root/
```

## dev-fossil 開発コンテナーのクリーニング

　dev-fossil 開発コンテナーのクリーニングをするには、次のように `fossil-clean.sh` を実行します。クリーニングしても良い状態にしてから、実行するようにしてください。

```console
cd ${REPO_DIR}
sh script/fossil-clean.sh
```

　このスクリプトは、dev-fossil 開発コンテナーが使っていた Docker ボリュームと Docker ネットワークといったリソースについて、完全に破棄します。実行すると、開発コンテナーを破棄してから、Docker ボリュームと Docker ネットワークも破棄します。
