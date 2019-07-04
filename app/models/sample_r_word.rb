class SampleRWord < ApplicationRecord
	belongs_to :sample_ring

	scope :active, -> { where(deleted_at: nil) }
end
