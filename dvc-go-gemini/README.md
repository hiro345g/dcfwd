# Dev Container + Gemini CLI による Go 開発

このプロジェクトは、シンプルな Go アプリケーション（`goapp001`）を[Dev Container](https://code.visualstudio.com/docs/remote/containers) を開発する方法を示すためのサンプルです。

Dev Container と Gemini CLI を利用することで、一貫性があり隔離された開発環境が提供され、複雑なローカル設定なしでプロジェクトを簡単に開始できます。

Zenn で、このプロジェクトについての解説記事を公開しています。

- [VS Code と Docker で始める！Go 開発入門 \- 2025年10月版](https://zenn.dev/hiro345/articles/20251022_vscode_go)

## 前提条件

- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- [Visual Studio Code](https://code.visualstudio.com/)
- VS Codeの[Remote - Containers 拡張機能](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

## はじめに

1. このリポジトリをローカルマシンにクローンします。
2. 開発コンテナ用イメージ `dvc-go-gemini` をビルドします。
3. Gemini 用の認証情報用フォルダを用意します。
4. Visual Studio Code で `dvc-go-gemini` フォルダを開きます。
5. 通知が表示されたら、「コンテナーで再度開く（Reopen in Container）」をクリックして Dev Container を起動します。これにより、コンテナイメージがビルドされ、開発環境が開始されます。
6. コンテナが起動したら、`goapp001` フォルダを VS Code で開いて、それぞれのアプリケーションの開発と実行を開始できます。

手順 1. から 5. はターミナル上で作業することができます。具体的には次のコマンドを実行します。

```bash
git clone https://github.com/hiro345g/dcfwd.git
cd dcfwd/dvc-go-gemini/
docker compose -f .devcontainer/compose.yaml build
cp -a ~/.gemini ./
code .
```

## プロジェクト構成

- `.devcontainer/`: Dev Container の設定ファイル（`devcontainer.json`, `compose.yaml`, `Dockerfile`）
- `goapp001/`: Go のサンプルアプリ
