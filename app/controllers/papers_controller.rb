class PapersController < ApplicationController
  before_action :login_check, except: [:sentence_ja, :sentence_ch, :word_ja, :word_ch]

  #-----------------------get-----------------------
  def edit
    @paper = Paper.find(id_params)
  end

  def get_for_paper_show
    @paper = Paper.find(paper_id_params)
    @user = @paper.user
    @sentences = @paper.sentences.active
    if @sentences.present?
      @unmemorized_sentences_ch_count = @sentences.unmemorized_ch.count
      @unmemorized_sentences_ja_count = @sentences.unmemorized_ja.count
      @unmemorized_words_ja_count = 0
      @unmemorized_words_ch_count = 0
      @sentences.each do |s|
        @unmemorized_words_ja_count += s.s_words.active.unmemorized_ja.count
        @unmemorized_words_ch_count += s.s_words.active.unmemorized_ch.count
      end
    end
  end

  def sentence_ja
    get_for_paper_show
  end

  def sentence_ch
    get_for_paper_show
  end

  def word_ja
    get_for_paper_show
  end

  def word_ch
    get_for_paper_show
  end

  #-----------------------post, put-----------------------
  def create
    Paper.create(create_params)
    redirect_to user_papers_path(current_user)
  end

  def update
    @paper = Paper.find(id_params)
    @paper.update(update_params)

    redirect_to paper_word_ch_path(@paper)
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
  def update_params
    params.require(:paper).permit(:name).merge(modified_at: Time.now)
  end

end
