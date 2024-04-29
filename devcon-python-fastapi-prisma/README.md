# devcon-python-fastapi-prisma

　これは、[FastAPI](https://pypi.org/project/fastapi/) と [Prisma Client Python（prisma）](https://pypi.org/project/prisma/) を使った Python アプリの学習用の開発環境について、Docker で用意する手順を説明するときに作成したものです。プロジェクト管理には [Poetry](https://python-poetry.org/) を使っています。

　技術的なキーワードを次に挙げておきます。

- Python
- FastAPI
- Prisma
- Docker
- VS Code 開発コンテナー

　用意してあるスクリプトは、説明用のものなので、できるだけ単純なコードにしてあります。また、機能も限られているので、複雑な処理はできません。説明用途以外では使いにくいものもあるので、承知しておいてください。

## ディレクトリ構成

```text
devcon-python-fastapi-prisma/
├── README.md ... このファイル
├── build-image/devcon-python-fastapi-prisma/ ... Python アプリ学習用の開発コンテナービルド用
│   └── resource/ ... 初期化時に使うリソースファイルを置く
├── dev/devcon-python-fastapi-prisma/ ... ここに compose.yaml を用意して Python アプリ学習用の開発コンテナーを使用
│   └── script/ ... Docker ホスト側で使用するスクリプト
├── sample/ ... サンプル
│   ├── build-image/ ... Python アプリ学習用の開発コンテナービルド用
│   │   ├── v0.0_init/devcon-python-fastapi-prisma ... 最初のビルド用
│   │   ├── v0.1/devcon-python-fastapi-prisma ... v0.1 ビルド用
│   │   ├── v0.2/devcon-python-fastapi-prisma ... v0.2 ビルド用
│   │   └── v0.3/devcon-python-fastapi-prisma ... v0.3 ビルド用
│   ├── python_src/ ... Python プログラム
│   │   ├── v0.0/app001 ... v0.0 版 Python プログラム
│   │   ├── v0.1/app001 ... v0.1 版 Python プログラム
│   │   ├── v0.2/app001 ... v0.2 版 Python プログラム
│   │   └── v0.3/app001 ... v0.3 版 Python プログラム
│   ├── compose/ ... Python アプリ学習用の開発コンテナー起動用サンプル
│   │   ├── v0.1/devcon-python-fastapi-prisma/compose.yaml
│   │   ├── v0.1-demo/devcon-python-fastapi-prisma/compose.yaml
│   │   ├── v0.2/devcon-python-fastapi-prisma/compose.yaml
│   │   ├── v0.2-demo/devcon-python-fastapi-prisma/compose.yaml
│   │   ├── v0.3/devcon-python-fastapi-prisma/compose.yaml
│   │   └── v0.3-demo/devcon-python-fastapi-prisma/compose.yaml
│   └── sample.env ... .env のサンプル
└── share/ ... Python アプリ学習用の開発コンテナーと Docker ホスト側とで共有
```
