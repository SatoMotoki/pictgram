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

  has_secure_password
end
