# README
## テーブルスキーマ
### Taskテーブル
| カラム名 | データ型 | 内容 |
|:--------|--------|-------:|
| id      | bigint | task_id |
| user_id | bigint | user_id |
| title   | string | タスク |
| content | text |   タスク内容 |
| priority| integer | 優先度 | 
| expired_at| datetime | 終了期限 | 
| status  | integer | ステータス | 
### Userテーブル
| カラム名 | データ型 | 内容 |
|:--------|--------|-------:|
| name    | string | 名前 |
| email   | string | email | 
| password_digest  | string | password |

___
## herokumのデプロイ手順
1.herokuにログインする
$ heroku login

2.Herokuに新しいアプリケーションを作成する
$ heroku create

3.アセットプリコンパイルをする
$ rails assets:precompile RAILS_ENV=production

4.GemfileのRubyのバージョンをコメントアウトする

5.$ bundle install

6.コミットする
$ git add -A
$ git commit -m "init"

7.Heroku buildpackを追加する
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs

8.Herokuにデプロイをする
$ git push heroku master