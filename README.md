# Dev Containers for Web Development

これは、開発コンテナーで Web アプリケーション開発（Dev Containers for Web Development）をするときに使用する開発コンテナーのサンプルを提供するリポジトリです。

VS Code の Dev Containers 拡張機能を使うと、開発コンテナーを使うことができるようになります。単純に VS Code をアタッチするという手軽な使い方から、`devcontainer.json` を用意して本格的に使うということもできます。

Web アプリケーション開発以外でも開発コンテナーを使いたいときはあるので、他のサンプルも提供しています。

| フォルダ名                   | 説明                                     |
| ---------------------------- | ---------------------------------------- |
| dev-fossil                   | fossil 利用                              |
| devcon-fossil                | node ユーザーによる fossil 利用          |
| devcon-python-fastapi-prisma | Python + FastAPI + Prisma                |
| dvc-go-gemini                | VS Code + Go プロジェクト                |
| dvc-java                     | VS Code + Java プロジェクト              |
| dvc-java-gemini              | VS Code + Gemini CLI + Java プロジェクト |
| dvc-mise                     | VS Code + mise                           |

## Dev Containers について

dcfwd では、Docker、Visual Studio Code (VS Code)、VS Code の拡張機能（Container Tools、Docker DX、Dev Containers）が使える環境が用意されていて、開発コンテナーが動作することを前提としています。

開発コンテナー（Dev Containers）については、開発が <https://github.com/devcontainers> でされていますので、そちらをご覧ください。

### Docker

- [Docker Engine](https://docs.docker.com/engine/)
- [Docker Compose](https://docs.docker.com/compose/)

これらは [Docker Desktop](https://docs.docker.com/desktop/) をインストールしてあれば使えます。Linux では Docker Desktop をインストールしなくても Docker Engine をインストールして使えます。例えば、Ubuntu を使っているなら [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/) を参照してインストールしておいてください。Docker Engine をインストールすると、Docker Compose もインストールされます。

### Visual Studio Code

Visual Studio Code とその拡張機能である Container Tools、Docker DX、Dev Containers をインストールしておく必要があります。VS Code と各拡張機能については、次の URL を参考にしてください。

- [Visual Studio Code](https://code.visualstudio.com/)
- 拡張機能
  - [Container Tools](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-containers)
  - [Docker DX](https://marketplace.visualstudio.com/items?itemName=docker.docker)
  - [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

## 実用的な開発コンテナー

開発コンテナーを自分でビルドしたカスタムイメージについて、Docker Hub と GitHub に自分でカスタマイズしたものを別途公開しています。そちらも参考にしてください。

### hiro345g/dvc

Dev Container based on mcr.microsoft.com/devcontainers/typescript-node (desktop-lite, docker-outside-of-docker, git, git-lfs)

Docker Hub で次のイメージを公開しています。ビルド用のコードについては <https://github.com/hiro345g/dvc> で公開しています。

| イメージ名:タグ   | os        | node | vnc   | mise | go   | jdk | php | python | ruby |
| ----------------- | --------- | ---- | ----- | ---- | ---- | --- | --- | ------ | ---- |
| dvc:base-202509   | debian 12 | 22   | -     | -    | -    | -   | -   | -      | -    |
| dvc:novnc-202509  | debian 12 | 22   | 1.2.0 | -    | -    | -   | -   | -      | -    |
| dvc:202509        | debian 12 | 22   | 1.2.0 | i    | -    | -   | -   | -      | -    |
| dvc:go-202509     | debian 12 | 22   | 1.2.0 | i    | 1.24 | -   | -   | -      | -    |
| dvc:jdk-202509    | debian 12 | 22   | 1.2.0 | i    | -    | 17  | -   | -      | -    |
| dvc:php-202509    | debian 12 | 22   | 1.2.0 | i    | -    | -   | 8.2 | -      | -    |
| dvc:python-202509 | debian 12 | 22   | 1.2.0 | i    | -    | -   | -   | 3.12   | -    |
| dvc:ruby-202509   | debian 12 | 22   | 1.2.0 | i    | -    | -   | -   | -      | 3.4  |
| dvc:gnr-202509    | debian 12 | 22   | 1.2.0 | i    | 1.24 | -   | -   | -      | 3.4  |
| dvc:gnpr-202509   | debian 12 | 22   | 1.2.0 | i    | 1.24 | -   | -   | 3.12   | 3.4  |

表について補足説明

- debian 12 のコードネームは bookworm
- vnc は tigervnc
- mise は jdx/mise の略、i でインストール済みでバージョンは 2025.9.8
- jdk は 21, 24 もインストール済み

いずれも <https://github.com/devcontainers/images/tree/main/src/typescript-node> で公開されている typescript-node 開発コンテナーをベースとしています。

Python、Go、Ruby などを使った Web アプリ開発もあるので、それに合わせてイメージを用意してあります。Web アプリの開発なので、Web ブラウザも使えるように desktop-lite の feature も組み合わせてあります。
[devcontainers/features](https://github.com/devcontainers/features/tree/main/src) で公開されている feature の組み合わせ方により使い分けています。
