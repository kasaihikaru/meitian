class ExploresController < ApplicationController
	def show
		@users = User.active.recent
		@passages = Passage.active.recent
		@papers = Paper.active.recent
		@rings = Ring.active.recent

		@users_cnt = User.active.count
		@passages_cnt = Passage.active.count
		@papers_cnt = Paper.active.count
		@rings_cnt = Ring.active.count
	end

	def users
		@users = User.active.order_updated_at.page(page_params).per(20)
	end

	def passages
		@passages = Passage.active.order_mofified_at.page(page_params).per(20)
	end

	def papers
		@papers = Paper.active.order_mofified_at.page(page_params).per(20)
	end

	def rings
		@rings = Ring.active.order_mofified_at.page(page_params).per(20)
	end
end