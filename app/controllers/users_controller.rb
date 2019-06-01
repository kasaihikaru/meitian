class UsersController < ApplicationController
  before_action :login_check, except: [:show]

  #-----------------------get-----------------------
  def show
    @user = User.find(id_params)
    get_user_theme
    get_recent_prs_list
    get_psr_counts
    get_new_paper_ring
  end

  def passages
    @user = User.find(user_id_params)
    @passages = @user.passages.active.order_mofified_at
    get_psr_counts
  end

  def papers
    @user = User.find(user_id_params)
    @papers = @user.papers.active.order_mofified_at
    get_psr_counts
    @paper = Paper.new
  end

  def rings
    @user = User.find(user_id_params)
    @rings = @user.rings.active.order_mofified_at
    get_psr_counts
    @ring = Ring.new
  end

  #-----------------------post, put-----------------------
  def destroy
  end
end
