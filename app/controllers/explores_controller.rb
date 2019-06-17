class ExploresController < ApplicationController
	def show
		if user_signed_in?
			users_all = User.active.not_me(current_user.id)
			passages_all = Passage.active.not_sapmle.not_copied.not_mine(current_user.id)
			papers_all = Paper.active.not_sapmle.not_copied.not_mine(current_user.id)
			rings_all = Ring.active.not_sapmle.not_copied.not_mine(current_user.id)
			sentences_all = Sentence.active.not_sapmle.not_copied.not_mine(current_user.id)
		else
			users_all = User.active
			passages_all = Passage.active.not_sapmle.not_copied
			papers_all = Paper.active.not_sapmle.not_copied
			rings_all = Ring.active.not_sapmle.not_copied
			sentences_all = Sentence.active.not_sapmle.not_copied
		end
		@users = users_all.recent
		@passages = passages_all.recent
		@papers = papers_all.recent
		@rings = rings_all.recent
		@sentences = sentences_all.recent

		@users_cnt = users_all.count
		@passages_cnt = passages_all.count
		@papers_cnt = papers_all.count
		@rings_cnt = rings_all.count
		@sentences_cnt = sentences_all.recent
	end

	def users
		if user_signed_in?
			@users = User.active.not_me(current_user.id).order_updated_at.page(page_params).per(20)
		else
			@users = User.active.order_updated_at.page(page_params).per(20)
		end
	end

	def passages
		if user_signed_in?
			@passages = Passage.active.not_mine(current_user.id).not_sapmle.not_copied.order_mofified_at.page(page_params).per(20)
		else
			@passages = Passage.active.not_sapmle.not_copied.order_mofified_at.page(page_params).per(20)
		end
	end

	def papers
		if user_signed_in?
			@papers = Paper.active.not_mine(current_user.id).not_sapmle.not_copied.order_mofified_at.page(page_params).per(20)
		else
			@papers = Paper.active.not_sapmle.not_copied.order_mofified_at.page(page_params).per(20)
		end
	end

	def rings
		if user_signed_in?
			@rings = Ring.active.not_mine(current_user.id).not_sapmle.not_copied.order_mofified_at.page(page_params).per(20)
		else
			@rings = Ring.active.not_sapmle.not_copied.order_mofified_at.page(page_params).per(20)
		end
	end
end