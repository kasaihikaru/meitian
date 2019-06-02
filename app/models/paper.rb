class Paper < ApplicationRecord
  belongs_to :user
  has_many :sentences

  scope :active, -> { where(deleted_at: nil) }
  scope :recent, -> { order(modified_at: :desc).limit(5) }
  scope :order_mofified_at, -> { order(modified_at: :desc) }
  scope :not_sapmle, -> { where(sample: false) }
  scope :not_copied, -> { where(original_id: nil) }
  scope :not_mine, -> user_id { where.not(user_id: user_id) }
end