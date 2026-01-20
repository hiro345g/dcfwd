# gradle-cargo-2026

これは、Java で Web アプリの開発をするときに使える開発コンテナのプロジェクトのサンプルです。

Java で Tomcat を使った Web アプリの開発をするためのプロジェクト `webapp001` をサンプルとして用意してあります。

`webapp001` では、[Gradle Cargo 2026 Plugin](https://central.sonatype.com/artifact/io.github.hiro345g/gradle-cargo-2026-plugin) を利用して、Tomcat サーバーのダウンロード、起動、デプロイ、デバッグを Gradle タスクで管理できるようにしてあります。

`sample` には、`webapp001` を gradle-cargo-2026 の開発コンテナで開発するときの設定ファイルのサンプルが含まれています。

解説記事を Zenn で公開しました。

- [Gradle で Tomcat を自動管理！開発コンテナで実現する Java Web 開発](https://zenn.dev/hiro345/articles/20260120_gradle-cargo-2026)
