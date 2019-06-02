class PapersController < ApplicationController
  before_action :login_check, except: [:sentence_ja, :sentence_ch, :word_ja, :word_ch]
  before_action -> {
    user_check_by_id(get_user_by_paper_id_for_paper)
  },only: [:uncheck_all_sentences_ja, :uncheck_all_sentences_ch, :uncheck_all_words_ja, :uncheck_all_words_ch]
  before_action -> {
    user_check_by_id(get_user_by_id_for_paper)
  },only: [:edit, :update, :destroy]


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
    paper = Paper.create(create_params)
    @mypapers = current_user.papers.active

    redirect_to new_sentence_path(paper_id: paper.id)
  end

  def update
    @paper = Paper.find(id_params)
    @paper.update(update_params)

    redirect_to paper_sentence_ch_path(@paper)
  end

  def destroy
    paper = Paper.find(id_params)
    paper.update(deleted_at: Time.now)
    paper.sentences.each do |sentence|
      sentence.update(deleted_at: Time.now)
      sentence.s_words.each do |word|
        word.update(deleted_at: Time.now)
      end
    end

    redirect_to user_papers_path(current_user)
  end

  def copy
    paper_id = Paper.find(paper_id_params).id
    user_id = current_user.id
    copy_specific_paper(paper_id, user_id, false)
    @msg = "自分の短文集として保存しました。"
  end

  def uncheck_all_sentences_ja
    paper = Paper.find(paper_id_params)
    paper.sentences.each do |sentence|
      sentence.update(memorized_ja: 0)
    end

    redirect_to paper_sentence_ja_path(paper)
  end

  def uncheck_all_sentences_ch
    paper = Paper.find(paper_id_params)
    paper.sentences.each do |sentence|
      sentence.update(memorized_ch: 0)
    end

    redirect_to paper_sentence_ch_path(paper)
  end

  def uncheck_all_words_ja
    paper = Paper.find(paper_id_params)
    paper.sentences.each do |sentence|
      sentence.s_words.each do |word|
        word.update(memorized_ja: 0)
      end
    end

    redirect_to paper_word_ja_path(paper)
  end

  def uncheck_all_words_ch
    paper = Paper.find(paper_id_params)
    paper.sentences.each do |sentence|
      sentence.s_words.each do |word|
        word.update(memorized_ch: 0)
      end
    end

    redirect_to paper_word_ch_path(paper)
  end

private
  def create_params
    params.require(:paper).permit(:name).merge(user_id: current_user.id, modified_at: Time.now)
  end
  def update_params
    params.require(:paper).permit(:name).merge(modified_at: Time.now)
  end

end
