class SampleSWord < ApplicationRecord
	belongs_to :sample_sentence

	scope :active, -> { where(deleted_at: nil) }
end
