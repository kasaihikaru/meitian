class PWord < ApplicationRecord
    belongs_to :passage

    scope :active, -> { where(deleted_at: nil) }
    scope :memorized_ja, -> { where(memorized_ja: true) }
    scope :memorized_ch, -> { where(memorized_ch: true) }
    scope :unmemorized_ja, -> { where(memorized_ja: false) }
    scope :unmemorized_ch, -> { where(memorized_ch: false) }
    scope :pin_fixed, -> { where(pin_fixed: true) }
end