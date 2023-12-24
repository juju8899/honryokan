class Post < ApplicationRecord
  # 有効なユーザーの投稿のみ表示
  scope :active_posts, -> { includes(:user).where('users.is_status': true) }
  # アソシエーション
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
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

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def self.looks(word)
    where("title LIKE ?", "%#{word}%")
  end
end


  # 三瓶さんのコード
  # Tagオブジェクトの名前を取得し(反復処理でname属性を取得)半角スペースで連結し文字として返す
#   def tag_list
#     tags.map(&:name).join(' ')
#   end
#   # 上記のメソッドの文字列を受け取り個別のタグとして分解しPostモデルに関連付け
#   def tag_list=(tags_string)
#     # tag_stringを半角全角スペースで分割、uniqメソッドで重複を排除、mapメソッド使用
#     tag_names = tags_string.split(/[\s\u3000]+/).uniq
#     # find_or_create_by(name: name)で各タグ名に対応するTagオブジェクトを取得or新規作成
#     new_or_found_tags = tag_names.map { |name| Tag.find_or_create_by(name: name) }
#     # ここで処理したタグをPostオブジェクトに関連付け
#     self.tags = new_or_found_tags
#   end
# end
