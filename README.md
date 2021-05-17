# README
## テーブルスキーマ
### Taskテーブル
| カラム名 | データ型 |
|:--------|-------:|
| id      | bigint | 
| user_id | bigint | 
| title   | string |
| content | text | 
| priority| string | 
| period  | string | 
| status  | string | 
### Userテーブル
| カラム名 | データ型 |
|:--------|-------:|
| name    | string | 
| email   | string | 
| password_digest  | string |

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