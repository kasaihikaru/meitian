class RWordsController < ApplicationController
  before_action :login_check
  #-----------------------get-----------------------
  def new
    @myrings = current_user.rings.active
  end

  def edit
    @r_word = RWord.find(id_params)
    @redirect_flg = params[:redirect_flg]
  end

  def edit_pin
    @word = RWord.find(r_word_id_params)
    @redirect_flg = params[:redirect_flg]
  end

  #-----------------------post, put-----------------------
  def create
    # 単語作成
    ring_id = ring_id_params
    r_word_params.each do |key,value|
      if value[:ja].present? && value[:ch].present?
        pinyin = get_pinyin(value[:ch])
        RWord.create("ja"=>value[:ja], "ch"=>value[:ch], "pin"=>pinyin, "ring_id"=> ring_id)
      end
    end

    # paperを最新化
    Ring.find(ring_id).update(modified_at: Time.now)

    #リダイレクト
    redirect_to ring_word_ch_path(ring_id)
  end

  def update
    r_word = RWord.find(id_params)
    if r_word.pin_fixed == true
      r_word.update("ja"=>update_params[:ja], "ch"=>update_params[:ch])
    else
      r_word.update("ja"=>update_params[:ja], "ch"=>update_params[:ch], "pin"=>update_params[:pin])
    end

    #リダイレクト
    if params[:r_word][:redirect_flg] == "word_ja"
      redirect_to ring_word_ja_path(r_word.ring.id, anchor: 'ring-words-ja')
    else
      redirect_to ring_word_ch_path(r_word.ring.id, anchor: 'ring-words-ch')
    end
  end

  def update_pin
    word = RWord.find(r_word_id_params)
    if word.pin != pin_params
      word.update(pin: pin_params, pin_fixed: 1)
    end

    #リダイレクト
    if params[:redirect_flg] == "word_ja"
      redirect_to ring_word_ja_path(word.ring.id, anchor: 'ring-words-ja')
    else
      redirect_to ring_word_ch_path(word.ring.id, anchor: 'ring-words-ch')
    end
  end

  def destroy
    r_word = RWord.find(id_params)
    r_word.update(deleted_at: Time.now)

    redirect_to ring_word_ch_path(r_word.ring)
  end

  def copy
    r_word = PWord.find(r_word_id_params)
    new_r_word = PWord.create(ring_id: ring_id_params, ja: r_word.ja, ch: r_word.ch, pin: r_word.pin)
  end

  def get_word_ring_for_check
    @word = RWord.find(r_word_id_params)
    @ring = @word.ring
  end

  def check_ja
    get_word_ring_for_check
    @word.update(memorized_ja: 1)
  end

  def check_ch
    get_word_ring_for_check
    @word.update(memorized_ch: 1)
  end

  def uncheck_ja
    get_word_ring_for_check
    @word.update(memorized_ja: 0)
  end

  def uncheck_ch
    get_word_ring_for_check
    @word.update(memorized_ch: 0)
  end



private
  def update_params
    pinyin = get_pinyin(params[:r_word][:ch])
    params.require(:r_word).permit(:ja, :ch).merge(pin: pinyin)
  end
end
