# docker

このディレクトリには、さまざまな環境向けの Docker の設定が含まれています。

## 各環境について

各環境について、次のファイルを用意してあります。

- Dockerfile: `docker/cicd/Dockerfile`
- Compose ファイル: `docker/cicd/compose.yaml`

### CI/CD (`docker/cicd`)

この設定は、CI/CD パイプラインで自動テストを実行するためのものです。

テストを実行する方法

```bash
docker compose -f docker/cicd/compose.yaml run --rm test
```

### デモ (`docker/demo`)

この設定は、ローカルの開発環境やデモ環境でアプリケーションを実行するためのものです。**ローカルのソースコードをマウントするため、変更が即座に反映されます**。

アプリケーションを実行する方法。デフォルトは`dev`モードで起動。

```bash
docker compose -f docker/demo/compose.yaml run --rm app
```

`compose.yaml`では`APP_ENV=dev`がデフォルトで設定されていますが、実行時に変数を指定することで上書きできます。

```bash
# 'prod'モードで実行する例
docker compose -f docker/demo/compose.yaml run --rm -e APP_ENV=prod app
```

### 3. 本番 (`docker/prod`)

この設定は、`distroless` ベースイメージを使用したマルチステージビルドにより、最小限でセキュアな本番イメージをビルドするためのものです。

**環境設定**:

本番用の Docker イメージは、`Dockerfile` 内の `ENV` 命令により、デフォルトで `APP_ENV=prod` に設定されています。

`docker/prod/compose.yaml` もこの環境変数を設定します。`compose.yaml` の値は `Dockerfile` のデフォルト値を上書きするため、イメージを再ビルドすることなく簡単に環境を変更できます。例えば、デバッグのために本番イメージを開発モードで実行したい場合、`compose.yaml` の値を `dev` に変更できます。

`compose.yaml` で指定されている `APP_ENV` の値は、`.env` ファイルで上書き可能です。そのため、`compose.yaml` の `APP_ENV` の値を変更する一番簡単な方法は、`docker/prod/.env` を次のように用意してからコンテナを起動するということになります。

```bash
echo "APP_ENV=dev` > `docker/prod/.env`
```

**使用方法**:

1. イメージのビルド
2. アプリケーションの実行

これにより、アプリケーションがバックグラウンドで起動します。

```bash
docker compose -f docker/prod/compose.yaml build
docker compose -f docker/prod/compose.yaml up
```

ログを確認するには次のようにします。ログについては、実際の運用時に別途、保持するサイズ、ローテートの設定、出力先の調整といった対応が必要です。

```bash
docker compose -p goapp001-prod logs
```

アプリの実行を終了するには `ocker compose down` します。

```bash
docker compose -p goapp001-prod down
```
