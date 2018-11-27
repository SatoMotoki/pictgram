class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, { presence: true, length: { maximum: 15} }
  validates :email, {presence: true, format: { with: VALID_EMAIL_REGEX } }
  validates :password, { format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,32}+\z/i } }

  # 下のコードを使うことで様々な機能を実装できる
  # 暗号化されたパスワードをデータベースのpassword_digestというカラムに保存できるようになる。
  # passwordとpassword_confirmationが使えるようになる。また、存在性と値が一致するかどうかのバリデーション(チェック)も追加される。
  # 引数の文字列がパスワードと一致するとUserオブジェクトを返し、間違っているとfalseを返す
  # authenticateメソッドが使えるようになる。
  has_secure_password

  # 以下のコードはテーブル間の関連付け(アソシエーション)
  # has_manyは、自分のテーブルが対象テーブルを複数もつ場合に使う
  # 対象テーブル側が自分のidのカラムがある場合に使う
  # Topicsテーブルと関連付け
  has_many :topics
  has_many :favorites

  # throughを使うことで、そのユーザーがいいねしたtopicデータを取得できる
  # userが紐づいているfavoritesが紐づいているtopicを取得している
  # sourceをシンボルではなく文字列の理由は？
  has_many :favorite_topics, through: :favorites, source: 'topic'
  has_many :comments
end
