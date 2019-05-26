class MesController < ApplicationController
	before_action :login_check

	def show
		@user = current_user
		get_user_theme
    get_recent_prs_list
    get_psr_counts
    get_new_paper_ring
	end
end