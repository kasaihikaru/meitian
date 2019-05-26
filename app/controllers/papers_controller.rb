class PapersController < ApplicationController
  before_action :login_check, except: [:sentence_ja, :sentence_ch, :word_ja, :word_ch]

  #-----------------------get-----------------------
  def edit
  end

  def sentence_ja
  end

  def sentence_ch
  end

  def word_ja
  end

  def word_ch
  end

  #-----------------------post, put-----------------------
  def create
    Paper.create(create_params)
    redirect_to user_papers_path(current_user)
  end

  def update
  end

  def destroy
  end

  def copy
  end

  def uncheck_all_sentences_ja
  end

  def uncheck_all_sentences_ch
  end

  def uncheck_all_words_ja
  end

  def uncheck_all_words_ch
  end

private
  def create_params
    params.require(:paper).permit(:name).merge(user_id: current_user.id, modified_at: Time.now)
  end

end
