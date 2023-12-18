class Tag < ApplicationRecord
  # アソシエーション
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags, source: :tag

  # バリデーション
  validates :name, presence:true, length: {maximum:50}
end
