class PWordsController < ApplicationController
  before_action :login_check
  #-----------------------get-----------------------
  def edit
  end

  def edit_pin
  end

  #-----------------------post, put-----------------------
  def create
  end

  def update
  end

  def destroy
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

  def update_pin
  end

private
  def p_word_id_params
    params[:p_word_id].to_i
  end

end

