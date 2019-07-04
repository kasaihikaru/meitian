class SampleSentence < ApplicationRecord
	belongs_to :sample_paper
	has_many :sample_s_words

	scope :active, -> { where(deleted_at: nil) }
end
