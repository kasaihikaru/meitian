class PWordsController < ApplicationController
  before_action :login_check
  before_action -> {
    user_check_by_id(get_user_by_p_word_id_for_p_word)
  },only: [:edit_pin, :update_pin, :check_ja, :check_ch, :uncheck_ja, :uncheck_ch]
  before_action -> {
    user_check_by_id(get_user_by_id_for_p_word)
  },only: [:edit, :update, :destroy]

  #-----------------------get-----------------------
  def edit
    @p_word = PWord.find(id_params)
    @redirect_flg = params[:redirect_flg]
  end

  def edit_pin
    @word = PWord.find(p_word_id_params)
    @redirect_flg = params[:redirect_flg]
  end

  #-----------------------post, put-----------------------
  def update
    p_word = PWord.find(id_params)
    if p_word.pin_fixed == true
      p_word.update("ja"=>update_params[:ja], "ch"=>update_params[:ch])
    else
      p_word.update("ja"=>update_params[:ja], "ch"=>update_params[:ch], "pin"=>update_params[:pin])
    end

    #リダイレクト
    if params[:p_word][:redirect_flg] == "word_ja"
      redirect_to passage_word_ja_path(p_word.passage.id, anchor: 'passage-words-ja')
    else
      redirect_to passage_word_ch_path(p_word.passage.id, anchor: 'passage-words-ch')
    end
  end

  def update_pin
    word = PWord.find(p_word_id_params)
    if word.pin != pin_params
      word.update(pin: pin_params, pin_fixed: 1)
    end

    #リダイレクト
    if params[:redirect_flg] == "word_ja"
      redirect_to passage_word_ja_path(word.passage.id, anchor: 'passage-words-ja')
    else
      redirect_to passage_word_ch_path(word.passage.id, anchor: 'passage-words-ch')
    end
  end

  def destroy
    p_word = PWord.find(id_params)
    p_word.update(deleted_at: Time.now)

    redirect_to passage_word_ch_path(p_word.passage)
  end




  #---------------------- 単語へのcheck----------------------
  def get_word_passage_for_check
    @word = PWord.find(p_word_id_params)
    @passage = @word.passage
  end

  def check_ja
    get_word_passage_for_check
    @word.update(memorized_ja: 1)
  end

  def check_ch
    get_word_passage_for_check
    @word.update(memorized_ch: 1)
  end

  def uncheck_ja
    get_word_passage_for_check
    @word.update(memorized_ja: 0)
  end

  def uncheck_ch
    get_word_passage_for_check
    @word.update(memorized_ch: 0)
  end


private
  def update_params
    pinyin = get_pinyin(params[:p_word][:ch])
    params.require(:p_word).permit(:ja, :ch).merge(pin: pinyin)
  end

end

