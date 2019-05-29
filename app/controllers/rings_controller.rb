class RingsController < ApplicationController
  before_action :login_check, except: [:word_ja, :word_ch]
  #-----------------------get-----------------------
  def edit
  end

  def get_for_ring_show
    @ring = Ring.find(ring_id_params)
    @user = @ring.user
    @words = @ring.r_words.active
    if @words.present?
      @unmemorized_words_ch_count = @words.unmemorized_ch.count
      @unmemorized_words_ja_count = @words.unmemorized_ja.count
    end
  end

  def word_ja
    get_for_ring_show
  end

  def word_ch
    get_for_ring_show
  end

  #-----------------------post, put-----------------------
  def create
    Ring.create(create_params)
    redirect_to user_rings_path(current_user)
  end

  def update
  end

  def destroy
  end

  def copy
  end

  def uncheck_all_words_ja
  end

  def uncheck_all_words_ch
  end

private
  def create_params
    params.require(:ring).permit(:name).merge(user_id: current_user.id, modified_at: Time.now)
  end

end
