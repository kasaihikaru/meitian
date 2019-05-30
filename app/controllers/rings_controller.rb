class RingsController < ApplicationController
  before_action :login_check, except: [:word_ja, :word_ch]
  #-----------------------get-----------------------
  def edit
    @ring = Ring.find(id_params)
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
    @ring = Ring.find(id_params)
    @ring.update(update_params)

    add_new_words_params.each do |w|
      if w[:ja].present? && w[:ch].present?
        pinyin = get_pinyin(w[:ch])
        RWord.create(ja: w[:ja], ch: w[:ch], ring_id: @ring.id, pin: pinyin)
      end
    end

    redirect_to ring_word_ch_path(@ring)
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

  def update_params
    params.require(:ring).permit(:name, r_words_attributes: [:ja, :ch, :_destroy, :id]).merge(, modified_at: Time.now)
  end



end
