# gradle-cargo-2026 開発コンテナ用サンプルファイル

このディレクトリには、gradle-cargo-2026 開発コンテナをセットアップするためのサンプルファイルが含まれています。

## `to-dvc-env.sh`

開発コンテナの起動時 (`postCreateCommand`) に自動で実行されるシェルスクリプトです。
`sample` ディレクトリに配置されている `VS Code` の Java プロジェクト用設定ファイル (`.classpath`, `.project` など) を、`webapp001` ディレクトリへコピーします。
これにより、開発者は手動で設定ファイルを配置することなく、`VS Code` が Java プロジェクトとして正しく認識した状態で開発を開始できます。
既存のファイルは `sample/backup` ディレクトリにバックアップされます。

## `restore-env.sh`

`to-dvc-env.sh` によってコピーされた設定ファイルを、バックアップから元の状態に戻すためのシェルスクリプトです。
開発コンテナを使わないときに使用する手動で用意した設定ファイルについて、`to-dvc-env.sh` で移動された場合に、それらを復帰させるのに使用できます。

## Java プロジェクト用設定ファイル

これらは元々 `Eclipse IDE` のための設定ファイルですが、`VS Code` の Java 拡張機能がプロジェクト構造を認識するためにも利用されます。

- `dot.classpath` (`.classpath`)
- `dot.project` (`.project`)
- `settings.org.eclipse.jdt.core.prefs` (`.settings/org.eclipse.jdt.core.prefs`)
- `settings.org.eclipse.wst.common.component` (`.settings/org.eclipse.wst.common.component`)
- `settings.org.eclipse.wst.common.project.facet.core.xml` (`.settings/org.eclipse.wst.common.project.facet.core.xml`)

## `webapp001.code-workspace`

`webapp001` プロジェクトを `VS Code` のワークスペースとして開くための設定ファイルです。
関連する拡張機能の推奨などが含まれています。

