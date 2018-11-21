class Topic < ApplicationRecord
  validates :user_id, presence: true
  validates :description, presence: true
  validates :image, presence: true

  # 以下のコードはテーブル間の関連付け(アソシエーション)
  # belongs_toは、自分のテーブルが対象テーブルのレコードに
  # 所属する場合(対象テーブルのidカラムがある)場合に使う
  # Userテーブルと関連付け
  belongs_to :user

  mount_uploader :image, ImageUploader
end
