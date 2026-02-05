# rubyapp001

## bundler の設定

インストールするライブラリは `vendor/bundle` に置く設定。

```bash
bundle config set --local path 'vendor/bundle'
```

確認

```bash
cat .bundle/config
```

実行例

```bash
node ➜ ~/workspace/rubyapp001 $ bundle config set --local path 'vendor/bundle'
node ➜ ~/workspace/rubyapp001 $ cat .bundle/config 
---
BUNDLE_PATH: "vendor/bundle"
```

## ruby 4.0.0

ruby 4.0.0 で実行

```bash
rvm use 4.0.0
bundle install
bundle exec ruby main.rb
bundle clean
```

実行例

```bash
node ➜ ~/workspace/rubyapp001 $ ruby --version
ruby 4.0.0 (2025-12-25 revision 553f1675f3) +PRISM [x86_64-linux]
node ➜ ~/workspace/rubyapp001 $ bundle install
Bundle complete! 1 Gemfile dependency, 0 gems now installed.
Bundled gems are installed into `./vendor/bundle`
node ➜ ~/workspace/rubyapp001 $ tree ./vendor/
./vendor/
└── bundle
    └── ruby
        └── 4.0.0

4 directories, 0 files
node ➜ ~/workspace/rubyapp001 $ bundle exec ruby main.rb
Hello, world!
node ➜ ~/workspace/rubyapp001 $ bundle clean
```

## ruby 3.4.8

ruby 3.4.8 で実行

```bash
rvm use 3.4.8
bundle install
tree ./vendor
bundle exec ruby main.rb
bundle clean
```

実行例

```bash
node ➜ ~/workspace/rubyapp001 $ tree ./vendor/
./vendor/
└── bundle
    └── ruby
        └── 4.0.0

4 directories, 0 files
node ➜ ~/workspace/rubyapp001 $ rvm use 3.4.8
Using /usr/local/rvm/gems/ruby-3.4.8
node ➜ ~/workspace/rubyapp001 $ bundle install
Bundle complete! 1 Gemfile dependency, 0 gems now installed.
Bundled gems are installed into `./vendor/bundle`
node ➜ ~/workspace/rubyapp001 $ tree ./vendor/
./vendor/
└── bundle
    └── ruby
        ├── 3.4.0
        └── 4.0.0

5 directories, 0 files
node ➜ ~/workspace/rubyapp001 $ bundle exec ruby main.rb
Hello, world!
```
