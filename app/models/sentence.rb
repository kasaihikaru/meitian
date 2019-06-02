class Sentence < ApplicationRecord
  belongs_to :paper
  has_many :s_words
  accepts_nested_attributes_for :s_words

  scope :active, -> { where(deleted_at: nil) }
  scope :memorized_ja, -> { where(memorized_ja: true) }
  scope :memorized_ch, -> { where(memorized_ch: true) }
  scope :unmemorized_ja, -> { where(memorized_ja: false) }
  scope :unmemorized_ch, -> { where(memorized_ch: false) }
  scope :pin_fixed, -> { where(pin_fixed: true) }
  scope :not_sapmle, -> { where(sample: false) }
  scope :not_copied, -> { where(original_id: nil) }
end