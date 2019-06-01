class Passage < ApplicationRecord
  belongs_to :user
  has_many :p_words
  accepts_nested_attributes_for :p_words

  scope :active, -> { where(deleted_at: nil) }
  scope :recent, -> { order(modified_at: :desc).limit(5) }
  scope :order_mofified_at, -> { order(modified_at: :desc) }

	validates :user_id, presence: true
	validates :title, presence: true
	validates :ch, presence: true
end