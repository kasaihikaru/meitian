class UsersController < ApplicationController
  before_action :login_check, except: [:show]

  #-----------------------get-----------------------
  def show
    @user = User.find(id_params)
    get_user_all_prs
    get_user_recent_prs
    get_user_psr_counts
    get_user_working_prs
    get_user_review_needed_prs
  end

  def passages
    @user = User.find(user_id_params)
    @passages = @user.passages.active.order_mofified_at
    get_user_all_prs
    get_user_psr_counts
  end

  def papers
    @user = User.find(user_id_params)
    @papers = @user.papers.active.order_mofified_at
    get_user_all_prs
    get_user_psr_counts
    @paper = Paper.new
  end

  def rings
    @user = User.find(user_id_params)
    @rings = @user.rings.active.order_mofified_at
    get_user_all_prs
    get_user_psr_counts
    @ring = Ring.new
  end

  #-----------------------post, put-----------------------
  def destroy
  end
end
