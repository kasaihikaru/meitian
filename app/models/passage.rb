class Passage < ApplicationRecord
  belongs_to :user
  has_many :p_words
  accepts_nested_attributes_for :p_words

  scope :active, -> { where(deleted_at: nil) }
  scope :recent, -> { order(modified_at: :desc).limit(5) }
  scope :order_mofified_at, -> { order(modified_at: :desc) }
  scope :not_sapmle, -> { where(sample: false) }
  scope :not_copied, -> { where(original_id: nil) }
  scope :not_mine, -> user_id { where.not(user_id: user_id) }

  enum status: { waiting: 0, working: 10, review_needed: 20, completed:30 }

	validates :user_id, presence: true
	validates :title, presence: true
	validates :ch, presence: true
end