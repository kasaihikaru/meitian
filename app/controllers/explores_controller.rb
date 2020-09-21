class ExploresController < ApplicationController
	def show
		@passages = Passage.active.not_sapmle.recent
		@papers = Paper.active.not_sapmle.recent
		@rings = Ring.active.not_sapmle.recent
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
			@passages = Passage.active.not_sapmle.order_mofified_at.page(page_params).per(20)
		else
			@passages = Passage.active.not_sapmle.order_mofified_at.page(page_params).per(20)
		end
	end

	def papers
		if user_signed_in?
			@papers = Paper.active.not_sapmle.order_mofified_at.page(page_params).per(20)
		else
			@papers = Paper.active.not_sapmle.order_mofified_at.page(page_params).per(20)
		end
	end

	def rings
		if user_signed_in?
			@rings = Ring.active.not_sapmle.order_mofified_at.page(page_params).per(20)
		else
			@rings = Ring.active.not_sapmle.order_mofified_at.page(page_params).per(20)
		end
	end
end