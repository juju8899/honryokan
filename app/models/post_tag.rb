class PostTag < ApplicationRecord
  # アソシエーション
  belongs_to :post
  belongs_to :post_tag
end
