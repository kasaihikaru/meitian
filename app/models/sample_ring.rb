class SampleRing < ApplicationRecord
	has_many :sample_r_words

	scope :active, -> { where(deleted_at: nil) }
	scope :level, ->level{ where(level: level) }
end
