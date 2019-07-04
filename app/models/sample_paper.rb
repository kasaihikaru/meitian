class SamplePaper < ApplicationRecord
	has_many :sample_sentences

	scope :active, -> { where(deleted_at: nil) }
	scope :level, ->level{ where(level: level) }
end
