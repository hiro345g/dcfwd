# Dev Containers for Web Development

　これは、開発コンテナーでWebアプリケーション開発（Dev Containers for Web Development）をするときに使用する開発コンテナーのサンプルを提供するリポジトリです。

　VS Code の Dev Containers 拡張機能を使うと、開発コンテナーを使うことができるようになります。単純に VS Code をアタッチするという手軽な使い方から、`devcontainer.json` を用意して本格的に使うということもできます。

## Dev Containers について

　開発コンテナー（Dev Containers）については、開発が <https://github.com/devcontainers> でされていますので、そちらをご覧ください。

### 必要なもの

　開発コンテナーを動作をさせるには、Docker、Docker Compose、Visual Studio Code (VS Code) 、Dev Containers 拡張機能が必要です。

### Docker

- [Docker Engine](https://docs.docker.com/engine/)
- [Docker Compose](https://docs.docker.com/compose/)

　これらは [Docker Desktop](https://docs.docker.com/desktop/) をインストールしてあれば使えます。Linux では Docker Desktop をインストールしなくても Docker Engine と Docker Compose だけをインストールして使えます。例えば、Ubuntu を使っているなら [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/) を参照してインストールしておいてください。

### Visual Studio Code

- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers 拡張機能](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

　VS Code の拡張機能である Dev Containers を VS Code へインストールしておく必要があります。

## 実用的な開発コンテナー

　開発コンテナーを自分でビルドしたカスタムイメージについて、Docker Hub と GitHub に自分でカスタマイズしたものを別途公開しています。そちらも参考にしてください。

| Docker イメージ名 | GitHub URL | 開発コンテナー | features |
|----|----|----|----|
|hiro345g/devcon-gnpr|<https://github.com/hiro345g/devcon-gnpr>| typescript-node | go, python, ruby, desktop-lite, docker-outside-of-docker, git, git-lfs |
|hiro345g/devcon-gnr|<https://github.com/hiro345g/devcon-gnr>| typescript-node | go, ruby, desktop-lite, docker-outside-of-docker, git, git-lfs |
|hiro345g/devnode-py-desktop|<https://github.com/hiro345g/devnode-py-desktop>| typescript-node | python, desktop-lite, docker-outside-of-docker, git, git-lfs |
|hiro345g/devnode-desktop|<https://github.com/hiro345g/devnode-desktop>| typescript-node | desktop-lite, docker-outside-of-docker, git, git-lfs |
|hiro345g/devcon-node|<https://github.com/hiro345g/devcon-node>| typescript-node | docker-outside-of-docker, git, git-lfs |

　いずれも <https://github.com/devcontainers/images/tree/main/src/typescript-node> で公開されている typescript-node 開発コンテナーをベースとしています。

　Python、Go、Ruby などを使った Web アプリ開発もあるので、それに合わせてイメージを用意してあります。Web アプリの開発なので、Web ブラウザも使えるように desktop-lite の feature も組み合わせてあります。
[devcontainers/features](https://github.com/devcontainers/features/tree/main/src) で公開されている feature の組み合わせ方により使い分けています。
