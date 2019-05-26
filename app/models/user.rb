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

  # ファイルアップロード処理
  mount_uploader :image, ImageUploader

  # trueだと、ブラウザ閉じてもログイン保持できる
  def remember_me
    true
  end
end
