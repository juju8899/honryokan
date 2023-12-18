class Post < ApplicationRecord
  # アソシエーション
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, source: :post
  # バリデーション
  validates :title, presence: true
  validates :point, presence: true

  def save_tags(tag_names)
    tag_names = tag_names.reject(&:empty?)# 空のタグ名を除外
    current_tags = self.tags.pluck(:name)
    old_tags = current_tags - tag_names
    new_tags = tag_names - current_tags

    # 古いタグを削除
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    # 新しいタグを追加
    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(name: new_name)
      self.post_tags << PostTag.create(tag: post_tag)
    end
  end
end
