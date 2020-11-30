# 概要
#### "Ks Essentails"は九州産業大学の学生に向けた掲示板アプリです。
※Essentailsとは必要不可欠のものという意味を持っています。（学生にとって必要不可欠な物になってもらいたいという意味でつけました）

このサービスは、『大学内で探したいを簡単に』をテーマにしています。

例えば、１万人以上いる大学で自分と同じ目標に向かって勉強している人を見つけるのはかなり困難だけど、このサービスを使うと簡単に見つけることができます！

# URL
<https://kyusan-university-app.herokuapp.com/>

右上のゲストログインから簡単にログインすることができます

# 使用技術・言語
* フロントエンド(HTML/CSS,Sass,Javascript,jQuery)
* バックエンド(Ruby on Rails6.0.3.4)
* テスト(RSpec, FactoryBot, Capybara)
* データベース(MySQL)
* 開発環境（Docker,Vscode,Git,GitHub)
* 本番環境 (Heroku)

# 機能
### ユーザ機能
* ユーザ新規登録機能 (devise)
* ログイン、ログアウト機能 (devise)
* ユーザ情報の編集
* プロフィール画像追加
* ユーザ一覧

### 投稿
* 投稿一覧
* 投稿検索機能
* いいね機能（投稿に対して）
* 新規投稿機能
* 投稿の削除、編集
* コメント機能
* コメントの削除

### その他
* フォロー機能
* DM機能(ajax)
* 通知機能
* 通知一覧
* 全通知削除


### UI
* ハンバーガーメニュー
* ページネーション機能（kaminari)
* topへ戻るボタン
* 通知お知らせ (未読の通知が何件あるか）
* タブメニュー機能

# 制作背景
大学生は大学という大きなコミニティに所属しているのに、そこで探したい人や物がすぐに探せないというのはかなり問題であり、もし簡単に探すことができたら、大学生活をよりよくすることができると思います。

私自身も大学内で同じ趣味や共通の目標を持っている人を簡単に探すことはできないだろうかと悩んでいました。

どうすればこの問題を解決できるのか考えたときに、このwebアプリを思いつき、制作しようと考えました。

# 使い方
### まずは新規登録
* 右上の赤茶色の新規登録ボタンをクリック
* ユーザ名（任意）、自分の学籍番号、メールアドレス、パスワード（６文字以上の英数字）、パスワードの確認を入力する

### プロフィールの変更をしよう
* 右上のマイページをクリックし、フォロー、フォロワー人数の下の編集ボタンを押すと編集ページへと飛ぶことができる
* プロフィールや画像を追加し、自分のプロフィールを充実させる

### 他の人の投稿を閲覧したり、気になる投稿を検索してみよう
* 他の人の投稿が閲覧したいときは、右上の投稿一覧をクリックする。投稿は一番上から最新の投稿が並んでいる
* 過去の投稿が見たいときは投稿の一番下の方にピンクのページ番号がついたボタンがあるのでそれをクリックする
* 右上の検索機能に気になる投稿に関するワードを入れて、検索ボタンを押すと検索結果が表示される

### 新規投稿をしてみよう
* 新規投稿をするには、まず右上の新規投稿ボタンをクリック
* そして、タイトルと本文の内容を入力、載せたい画像がある場合は本文のスペースの下のファイルを選択をクリック、最後に投稿するボタンを押すと投稿完了
* 投稿の例
* サークルのメンバー募集
* 大学内で同じ趣味を持った人を探す
* 同じ目標に向かって勉強している仲間を探す
* 大学内で忘れ物した人を探す

### プライベートのやりとりにはDM機能を使おう
* DMを送りたい人のユーザ情報ページにいき、右上のDMを始めるボタンをクリックするとDMページの飛ぶことができメッセージを送信することができる
* ユーザを探したいときは右上のユーザ一覧を活用しよう
* マイページから過去にDMしたユーザを確認することができる

### 通知をチェックしよう
* 通知を確認したいときは右上の通知ボタンをクリックすると通知一覧が確認することができる
* 通知を削除したいときは通知一覧画面の全件削除を押すと削除ができる
* 未読の通知がある場合は通知ボタンの右上に黄色のマークが現れ、何件未読があるか教えてくれる
* 通知の内容
* 誰かにフォローされたとき
* 自分の投稿に誰かがコメントしたとき
* 自分がコメントした投稿に誰かがコメントしたとき
* 誰かがDMを送ってきたとき
* 自分の投稿に誰かがいいねしたとき

