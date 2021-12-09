## README

# アプリ名

お米市場フリマアプリ
<br>
<br>

# アプリケーションの概要

ユーザーを登録すると商品を出品できるようになります。
自身が出品した商品は、編集と削除をすることができます。
他のユーザーが出品した商品は、クレジットカードを用いて購入することができます。
<br>
<br>

# URL 

#### Herokuによるデプロイ
https://okome_ichiba.herokuapp.com/

<br>
<br>

# テスト用アカウント
#### Basic認証
- ID: admin
- Pass: 2222

#### 購入者用
- メールアドレス: a@1
- パスワード: 111aaa

#### 購入用カード情報(PAYJPテスト用)
- 番号：4242424242424242
- 期限：3月/（20）22年（未来の年月であれば可能）
- セキュリティコード：123

#### 出品者用
- メールアドレス名: a@2
- パスワード: 111aaa
<br>
<br>

# 利用方法
- 1.トップページの一覧ページのヘッダーから会員登録を行う。
- 2.右下の出品ボタンを押し商品情報を入れて出品する。
- 3.購入する場合は他の人が出品した商品をクリックし商品詳細画面から購入ボタンを押して購入する。
- 4.自分の商品情報を修正した場合は商品詳細画面から編集/削除を行う。

<br>
<br>

# アプリケーションを開発した背景
生産者が大切に作ったお米を購入者と手軽につなぐ仕組みを構築したいと思いました。
少しだけ残ったお米を販売したい。でも大きなシステムに登録するのは大変。
不特定多数の人に販売する複雑なシステムではなく知人同士で簡単に販売ができるお米に特化した
スリムなアプリを検討しました。

<br>
<br>


# 洗い出した要件
https://docs.google.com/spreadsheets/d/15sQCIfp_DAB3xDQqNoSAsrIPSCPSS1RPEm-l7v03ej8/edit#gid=982722306

<br>
<br>

## 実装した機能
<br>

[![Image from Gyazo](https://i.gyazo.com/52f0ff7a6850479b31bcc14bd5242ed9.gif)](https://gyazo.com/52f0ff7a6850479b31bcc14bd5242ed9)

## 1.ユーザー登録機能
ユーザー登録することで出品・購入できるようになります。（ユーザー登録していない人でも出品している商品を見ることは可能です。）
[![Image from Gyazo](https://i.gyazo.com/25a6ef5e80a5014db9594e416379a581.png)](https://gyazo.com/25a6ef5e80a5014db9594e416379a581)
<br>

## 2.商品出品機能
商品画像を選択し、商品情報や販売したい金額を入力すると、出品することができます。（JavaScriptで販売手数料が表示されるようになっています。）
[![Image from Gyazo](https://i.gyazo.com/c46dd86ad2d1b349ca173c2ae9ae5f79.png)](https://gyazo.com/c46dd86ad2d1b349ca173c2ae9ae5f79)
<br>

## 3.商品の編集機能
出品した商品について、編集することができます。その際に、ユーザーの手間を省くため出品時の情報が表示されるようになっています。

[![Image from Gyazo](https://i.gyazo.com/a684f2b699fc2dcae16d6bbddafe3b90.png)](https://gyazo.com/a684f2b699fc2dcae16d6bbddafe3b90)

<br>

## 4.商品の削除機能
出品中であった商品について、削除ボタンを押すことで商品を削除することができます。

[![Image from Gyazo](https://i.gyazo.com/50c413623e555709445a088b4d852979.png)](https://gyazo.com/50c413623e555709445a088b4d852979)

<br>

## 5.商品の購入機能
出品者以外であれば、商品を購入することができます。カード情報と配送先を入力すると購入できます。（JavaScriptとフォームオブジェクトを使用し、トークン化したカード情報をPAY.JPに送付しつつ、カード情報がアプリケーションのデータベースに保存されないように設計しています。）

[![Image from Gyazo](https://i.gyazo.com/a5c87dc3eff99e7ec6c976ab4d889187.png)](https://gyazo.com/a5c87dc3eff99e7ec6c976ab4d889187)

<br>
<br>

# 実装予定の機能
- 購入履歴
- 販売履歴
<br>
<br>


# ER図

[![Image from Gyazo](https://i.gyazo.com/13aea71aa832d3746d448001810fdd1a.png)](https://gyazo.com/13aea71aa832d3746d448001810fdd1a)
<br>
<br>

# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| family_name        | string  | null: false               |
| first_name         | string  | null: false               |
| family_name_kana   | string  | null: false               |
| first_name_kana    | string  | null: false               |
| birthday           | date    | null: false               |


### Association

- has_many :items
- has_many :orders

<br>
<br>

## items テーブル

| Column          | Type      | Options                        |
| --------------- | --------- | ------------------------------ |
| name            | string    | null: false                    |
| explanation     | text      | null: false                    |
| price           | integer   | null: false                    |
| category_id     | integer   | null: false                    |
| status_id       | integer   | null: false                    |
| postage_id      | integer   | null: false                    |
| user            | references| null: false, foreign_key: true |
| prefecture_id   | integer   | null: false                    |
| shipping_day_id | integer   | null: false,                   |


### Association

- belongs_to :user
- has_one :order

<br>
<br>

## orders テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| item            | references | null: false, foreign_key: true |
| user            | references | null: false, foreign_key: true |


### Association

- belongs_to :item
- has_one :delivery

<br>
<br>

## deliverys テーブル

| Column          | Type      | Options                            |
| --------------- | ----------| ---------------------------------- |
| orders          | references| null: false, foreign_key: true     |
| postal_code     | string    | null: false                        |
| prefecture_id   | integer   | null: false                        |
| city            | string    | null: false                        |
| house_number    | string    | null: false                        |
| build_number    | string    |                                    |
| phone_number    | string    | null: false                        |


### Association

- belongs_to :order
<br>
<br>

# 画面遷移図
[![Image from Gyazo](https://i.gyazo.com/c35febf3df453e028983d76f51b48ff3.png)](https://gyazo.com/c35febf3df453e028983d76f51b48ff3)
<br>
<br>


# 開発環境

- フロントエンド：HTML,CSS / JavaScript
- バックエンド：Ruby (ver 2.6.5) / Ruby on Rails (ver 6.0.4.10)
- インフラ：Heroku , AWS(S3) , MySQL (ver 5.6.51)
- テスト：RSpec
- テキストエディタ：Visual Studio Code
- タスク管理：GitHubプロジェクトボード

<br>
<br>

# ローカルでの動作方法

```
% git clone https://github.com/mondenchan/okome_ichiba.git

% cd okome_ichiba
% bundle install
% rails db:create
% rails db:migrate
% yarn install
```
