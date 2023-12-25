class User < ApplicationRecord
  # 有効なユーザー/退会済みユーザー
  scope :active_users, -> { where(is_status: true) }
  scope :delete_users, -> { where(is_status: false) }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :authentication_keys => [:nick_name]

  # アソシエーション
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  # バリデーション
  validates :nick_name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 150 }
  validates :email, presence: true, uniqueness: true

  # ゲストログインメソッド追加
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64

      user.nick_name = "guestuser"
    end
  end

  # ゲストユーザーの判別メソッド
  def guest_user?
    email == GUEST_USER_EMAIL
  end

  # プロフィール画像追加
  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
