# Dev ContainerによるJava開発

このプロジェクトは、シンプルなJavaアプリケーション（`java-app001`）を [Dev Container](https://code.visualstudio.com/docs/remote/containers) 内で開発する方法を示すためのサンプルです。

Dev Container を利用することで、一貫性があり隔離された開発環境が提供され、複雑なローカル設定なしでプロジェクトを簡単に開始できます。

このプロジェクトについての解説記事を下記で公開しています。

1. [VS Code と Docker で始める！シンプルな Java 開発入門](https://zenn.dev/hiro345/articles/20250910_vscode_java)
2. [Java プロジェクトを Gemini CLI に対応させよう](https://zenn.dev/hiro345/articles/20250912_vscode_java_02)

`java-app001` が開発用です。

## 前提条件

- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- [Visual Studio Code](https://code.visualstudio.com/)
- VS Codeの[Remote - Containers 拡張機能](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

## はじめに

1. このリポジトリをローカルマシンにクローンします。
2. Visual Studio Code で `dvc-java` フォルダを開きます。
3. 通知が表示されたら、「コンテナーで再度開く（Reopen in Container）」をクリックして Dev Container を起動します。これにより、コンテナイメージがビルドされ、開発環境が開始されます。
4. コンテナが起動したら、`java-app001`アプリケーションの開発と実行を開始できます。

## プロジェクト構成

- `.devcontainer/`: Dev Container の設定ファイル（`devcontainer.json`）
- `java-app001/`: サンプルの Java アプリケーション
