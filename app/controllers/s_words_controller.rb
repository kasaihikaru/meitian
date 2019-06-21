class SWordsController < ApplicationController
  before_action :login_check
  before_action -> {
    user_check_by_id(get_user_by_s_word_id_for_s_word)
  },only: [:edit_pin, :update_pin, :check_ja, :check_ch, :uncheck_ja, :uncheck_ch]
  before_action -> {
    user_check_by_id(get_user_by_id_for_s_word)
  },only: [:edit, :update, :destroy]

  #-----------------------get-----------------------
  def edit
    @s_word = SWord.find(id_params)
    @redirect_flg = params[:redirect_flg]
  end

  def edit_pin
    @word = SWord.find(s_word_id_params)
    @redirect_flg = params[:redirect_flg]
  end

  #-----------------------post, put-----------------------
  def update
    s_word = SWord.find(id_params)
    if s_word.pin_fixed == true
      s_word.update("ja"=>update_params[:ja], "ch"=>update_params[:ch])
    else
      s_word.update("ja"=>update_params[:ja], "ch"=>update_params[:ch], "pin"=>update_params[:pin])
    end

    #リダイレクト
    if params[:s_word][:redirect_flg] == "word_ja"
      redirect_to paper_word_ja_path(s_word.sentence.paper.id, anchor: 'paper-words-ja')
    else
      redirect_to paper_word_ch_path(s_word.sentence.paper.id, anchor: 'paper-words-ch')
    end
  end

  def update_pin
    word = SWord.find(s_word_id_params)
    if word.pin != pin_params
      word.update(pin: pin_params, pin_fixed: 1)
    end

    #リダイレクト
    if params[:redirect_flg] == "word_ja"
      redirect_to paper_word_ja_path(word.sentence.paper.id)
    else
      redirect_to paper_word_ch_path(word.sentence.paper.id)
    end
  end
  def destroy
  end

  def get_word_sentence_for_check
    @word = SWord.find(s_word_id_params)
    @paper = @word.sentence.paper
    @sentences = @paper.sentences.active
    @memorized_count = 0
    @all_count = 0
  end
  def check_ja
    get_word_sentence_for_check
    @word.update(memorized_ja: 1)
    @sentences.each do |s|
      @all_count += s.s_words.active.count
      @memorized_count += s.s_words.active.memorized_ja.count
    end
    get_progress
  end
  def check_ch
    get_word_sentence_for_check
    @word.update(memorized_ch: 1)
    @sentences.each do |s|
      @all_count += s.s_words.active.count
      @memorized_count += s.s_words.active.memorized_ch.count
    end
    get_progress
  end
  def uncheck_ja
    get_word_sentence_for_check
    @word.update(memorized_ja: 0)
    @sentences.each do |s|
      @all_count += s.s_words.active.count
      @memorized_count += s.s_words.active.memorized_ja.count
    end
    get_progress
  end
  def uncheck_ch
    get_word_sentence_for_check
    @word.update(memorized_ch: 0)
    @sentences.each do |s|
      @all_count += s.s_words.active.count
      @memorized_count += s.s_words.active.memorized_ch.count
    end
    get_progress
  end


private
  def update_params
    pinyin = get_pinyin(params[:s_word][:ch])
    params.require(:s_word).permit(:ja, :ch).merge(pin: pinyin)
  end
end
