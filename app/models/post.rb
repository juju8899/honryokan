class Post < ApplicationRecord
  # アソシエーション
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tag, dependent: :destroy
  # バリデーション
  validates :title, presence: true
  validates :point, presence: true
end
