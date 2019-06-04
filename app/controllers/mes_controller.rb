class MesController < ApplicationController
	before_action :login_check

	def show
		@user = current_user
		get_user_theme
		get_user_all_prs
		get_user_recent_prs
		get_user_psr_counts
		get_user_working_prs
		get_user_review_needed_prs
	end
end