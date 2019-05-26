class Ring < ApplicationRecord
  belongs_to :user
  has_many :r_words

  scope :active, -> { where(deleted_at: nil) }
  scope :recent, -> { order(modified_at: :desc).limit(5) }
  scope :order_mofified_at, -> { order(modified_at: :desc) }
end