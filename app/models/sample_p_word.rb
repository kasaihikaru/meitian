class SamplePWord < ApplicationRecord
	belongs_to :sample_passage

	scope :active, -> { where(deleted_at: nil) }
end
