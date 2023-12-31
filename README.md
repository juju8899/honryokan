# 本旅館
​
## サイト概要
### サイトテーマ
他の人がおすすめしている本を見たり、自分もおすすめの本について投稿したりできるコミュニティサイト
​
### テーマを選んだ理由
私はたまに息抜きとして読書をしますが、自分の好みで読んでいるとどうしても系統が偏ってしまいます。
しかしいきなり違う分野の本を読もうとしても、どれがいいのか決めかねて結局いつもと似たようなジャンルの本を購入してしまうことが多いです。
そこでいろいろな人のおすすめ本が見れるサイトがあれば、全く未知の分野でも読んでみたいと思える本が見つかるのではないかと考えました。
また普段あまり読書をしない人でも、気になる本が見つかり読書を始めるきっかけになるかもしれないと思い、このテーマにしました。
​
### ターゲットユーザ
* いろいろなジャンルの本を読んでみたいと思っている人
* 日々の読書がマンネリ化してきた人
* 読書したいけどどの本を選べばいいかわからない人
​
### 主な利用シーン
* 自分のおすすめの本を投稿する時
* いろいろな人のおすすめしている本が知りたい時
​
## 設計書
* アプリケーション詳細設計(https://docs.google.com/spreadsheets/d/1F97TaBzSVFI0hLVlNj6xEdYpXk7p7w2BFgrkH4qxYmQ/edit#gid=549108681)
* テーブル定義書(https://docs.google.com/spreadsheets/d/1Jp9VOZNjasdXlqAnW_r-x1LHVPF02oKA/edit#gid=986568156)
​
## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9
​
## 使用素材
- 外部からのデータ取得として以下を使用
   * RakutenDevelopers (https://webservice.rakuten.co.jp/documentation/books-book-search#siteHead)

## ER図
![ER Diagram](https://github.com/juju8899/honryokan/blob/develop/PF.ER%E5%9B%B3.drawio.svg)