class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :passages
  has_many :papers
  has_many :rings
  has_many :themes
  accepts_nested_attributes_for :themes

  scope :active, -> { where(deleted_at: nil) }
  scope :recent, -> { order(updated_at: :desc).limit(5) }
  scope :order_updated_at, -> { order(updated_at: :desc) }
  scope :not_me, -> user_id { where.not(id: user_id) }

  validates :name,    length: { maximum: 12 }

  # ファイルアップロード処理
  mount_uploader :image, ImageUploader

  # trueだと、ブラウザ閉じてもログイン保持できる
  def remember_me
    true
  end
end
