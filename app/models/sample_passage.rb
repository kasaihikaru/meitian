class SamplePassage < ApplicationRecord
	has_many :sample_p_words

	scope :active, -> { where(deleted_at: nil) }
	scope :level, ->level{ where(level: level) }
end