# dvc-ruby4-202602

## 概要

このプロジェクトは、Ruby 開発用の Dev Container 環境を提供します。
RVM（Ruby Version Manager）がプリインストールされており、Ruby `4.0.0` と `3.4.8` を切り替えて使用できます。

## 1. 前提条件

この開発環境を使用するには、以下のソフトウェアがインストールされている必要があります。

- [Docker](https://www.docker.com/)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) (VS Code拡張機能)

## 2. セットアップ手順

### 2.1. 開発コンテナ用イメージのビルド

まず、この開発環境で使用するDockerイメージをビルドします。

1. ターミナルを開き、ビルドスクリプトを実行します。

```bash
bash ./build-image/build.sh
```

これにより、`dvc-ruby4-202602` という名前の Docker イメージが作成されます。

### 2.2. 開発コンテナの起動

次に、VS Codeで開発コンテナを起動します。

1. VS Code で、このプロジェクトのルートディレクトリを開きます。
2. コマンドパレットを開き (`Ctrl+Shift+P` または `Cmd+Shift+P`)、「`Dev Containers: Reopen in Container`」と入力して実行します。
3. VS Code がコンテナをビルドし、開発環境として開きます。

## 3. 動作確認

開発コンテナが正常に起動したら、サンプルアプリケーションを実行して環境を確認します。

1. 開発コンテナ内のターミナルを開きます。
2. 開発コンテナ内の `/share/rubyapp001` のサンプルアプリケーションを `/workspace/rubyapp001` へコピーします。
3. ターミナルのカレントディレクトリを `/workspace/rubyapp001` にします。
4. `/workspace/rubyapp001/README.md` の手順に従い、Rubyのバージョンを切り替え、アプリケーションを実行します。

```bash
cp -r /share/rubyapp001 /workspace/
cd /workspace/rubyapp001
```

Ruby 4.0.0で実行する場合は次の手順となります。

```bash
# Bundlerのインストール先をプロジェクト配下に設定
bundle config set --local path 'vendor/bundle'

# Rubyのバージョンを指定
rvm use 4.0.0

# 依存関係をインストール
bundle install

# プログラムを実行
bundle exec ruby main.rb
```

実行後、コンソールに `Hello, world!` と表示されれば成功です。実行例は次のようになります。

```bash
node ➜ ~/workspace/rubyapp001 $ bundle exec ruby main.rb
Hello, world!
```

次に Ruby 3.4.8 で実行してみます。4.0.0 を使う場合と同様です。

```bash
rvm use 3.4.8
bundle install
bundle exec ruby main.rb
```
