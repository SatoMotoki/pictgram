class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, {
    presence: true,
    length: {maximum: 15}
  }
  validates :email, {
    presence: true,
    format: { with: VALID_EMAIL_REGEX }
  }
  validates :password, {
    # length: { in: 8..32 },
    # format: { with: /([0-9].*[a-zA-Z]|[a-zA-Z].*[0-9])/ },
    format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,32}+\z/i }
  }

  # 下のコードを使うことで様々な機能を実装できる
  # 暗号化されたパスワードをデータベースのpassword_digestというカラムに保存できるようになる。
  # passwordとpassword_confirmationが使えるようになる。また、存在性と値が一致するかどうかのバリデーション(チェック)も追加される。
  # 引数の文字列がパスワードと一致するとUserオブジェクトを返し、間違っているとfalseを返す
  # authenticateメソッドが使えるようになる。
  has_secure_password
end
