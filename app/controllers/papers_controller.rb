class PapersController < ApplicationController
  before_action :login_check, except: [:show, :index]
  before_action -> {
    user_check_by_id(get_user_by_paper_id_for_paper)
  },only: [:uncheck_all_sentences_ja, :uncheck_all_sentences_ch, :uncheck_all_words_ja, :uncheck_all_words_ch, :waiting, :working, :review_needed, :completed]
  before_action -> {
    user_check_by_id(get_user_by_id_for_paper)
  },only: [:edit, :update, :destroy]


  #-----------------------get-----------------------
  def edit
    @paper = Paper.find(id_params)
  end

  def show
    @paper = Paper.find(id_params)
    @user = @paper.user

    # sentences
    @sentences = @paper.sentences.active
    @all_sentence_count = @sentences.count
    @memorized_sentence_count_ch = @sentences.memorized_ch.count
    @memorized_sentence_count_ja = @sentences.memorized_ja.count
    get_sentence_progresses

    # words
    @all_count = 0
    @memorized_count_ch = 0
    @memorized_count_ja = 0
    if @sentences.present?
      @sentences.each do |s|
        @all_count += s.s_words.active.count
        @memorized_count_ch += s.s_words.active.memorized_ch.count
        @memorized_count_ja += s.s_words.active.memorized_ja.count
      end
    end
    get_progresses
  end

  def index
    @papers = Paper.active.not_sapmle.order_mofified_at.page(page_params).per(20)
  end

  def get_for_paper_show
    @paper = Paper.find(paper_id_params)
    @user = @paper.user
    @sentences = @paper.sentences.active
  end

  def sentence_ja
    get_for_paper_show
    # プログレス用カウント
    if @sentences.present?
      @all_count = @sentences.count
      @memorized_count = @sentences.memorized_ja.count
      get_progress
    end
  end

  def sentence_ch
    get_for_paper_show
    # プログレス用カウント
    if @sentences.present?
      @all_count = @sentences.count
      @memorized_count = @sentences.memorized_ch.count
      get_progress
    end
  end

  def word_ja
    get_for_paper_show
    # プログレス用カウント
    if @sentences.present?
      @memorized_count = 0
      @all_count = 0
      @sentences.each do |s|
        @all_count += s.s_words.active.count
        @memorized_count += s.s_words.active.memorized_ja.count
      end
      get_progress
    end
  end

  def word_ch
    get_for_paper_show
    # プログレス用カウント
    if @sentences.present?
      @memorized_count = 0
      @all_count = 0
      @sentences.each do |s|
        @all_count += s.s_words.active.count
        @memorized_count += s.s_words.active.memorized_ch.count
      end
      get_progress
    end
  end

  #-----------------------post, put-----------------------
  def create
    paper = Paper.create(create_params)
    @mypapers = current_user.papers.active

    redirect_to new_sentence_path(paper_id: paper.id)
  end

  def update
    #瞬間作文集名更新
    @paper = Paper.find(id_params)
    @paper.update(update_params)

    # 文章がある時のみ既存を更新
    if @paper.sentences.present?
      #文章更新
      sentences = sentences_attribute_params(@paper.id)
      sentences.each do |sentence|
        original_sentence = Sentence.find(sentence[:id])
        if original_sentence.pin_fixed == true
          original_sentence.update(ja: sentence[:ja], ch: sentence[:ch])
        else
          original_sentence.update(ja: sentence[:ja], ch: sentence[:ch], pin: sentence[:pin])
        end
      end

      #単語更新
      words = words_attribute_params(@paper.id)
      words.each do |word|
        original_word = SWord.find(word[:id])
        if original_word.pin_fixed == true
          original_word.update(ja: word[:ja], ch: word[:ch])
        else
          original_word.update(ja: word[:ja], ch: word[:ch], pin: word[:pin])
        end
      end

      # 既存瞬間作文へ新規wordを追加

      add_new_words_params.each do |word|
        if word[:ja].present? && word[:ch].present?
          pinyin = get_pinyin(word[:ch])
          SWord.create(ja: word[:ja], ch: word[:ch], sentence_id: word[:id], pin: pinyin)
        end
      end
    end

    #新規瞬間作文の追加
    add_new_sentences_params.each do |sentence|
      if sentence[:ja].present? && sentence[:ch].present?
        pinyin = get_pinyin(sentence[:ch])
        new_sentence = Sentence.create(ja: sentence[:ja], ch: sentence[:ch], pin: pinyin, paper_id: @paper.id)
        add_new_sentence_words_params(sentence).each do |word|
          if word[:ja].present? && word[:ch].present?
            word_pinyin = get_pinyin(word[:ch])
            SWord.create(ja: word[:ja], ch: word[:ch], pin: word_pinyin, sentence_id: new_sentence.id)
          end
        end
      end
    end

    # show_render用 - user
    @user = @paper.user

    # show_render用 - sentences
    @sentences = @paper.sentences.active
    @all_sentence_count = @sentences.count
    @memorized_sentence_count_ch = @sentences.memorized_ch.count
    @memorized_sentence_count_ja = @sentences.memorized_ja.count
    get_sentence_progresses

    # show_render用 - words
    @all_count = 0
    @memorized_count_ch = 0
    @memorized_count_ja = 0
    if @sentences.present?
      @sentences.each do |s|
        @all_count += s.s_words.active.count
        @memorized_count_ch += s.s_words.active.memorized_ch.count
        @memorized_count_ja += s.s_words.active.memorized_ja.count
      end
    end
    get_progresses
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
    @msg = "マイ教材として保存しました。"
  end

  def uncheck_all_sentences_ja
    @paper = Paper.find(paper_id_params)
    @user = @paper.user
    @sentences = @paper.sentences
    @sentences.each do |sentence|
      sentence.update(memorized_ja: 0)
    end
    @progress_sentence_ja = 0
    @memorized_sentence_count_ja = 0
    @all_sentence_count = @sentences.count
  end

  def uncheck_all_sentences_ch
    @paper = Paper.find(paper_id_params)
    @user = @paper.user
    @sentences = @paper.sentences
    @sentences.each do |sentence|
      sentence.update(memorized_ch: 0)
    end
    @progress_sentence_ch = 0
    @memorized_sentence_count_ch = 0
    @all_sentence_count = @sentences.count
  end

  def uncheck_all_words_ja
    @paper = Paper.find(paper_id_params)
    @user = @paper.user
    @sentences = @paper.sentences
    @all_count = 0
    @sentences.each do |sentence|
      sentence.s_words.each do |word|
        word.update(memorized_ja: 0)
      end
      @all_count += sentence.s_words.active.count
    end
    @progress_ja = 0
    @memorized_count_ja = 0
  end

  def uncheck_all_words_ch
    @paper = Paper.find(paper_id_params)
    @user = @paper.user
    @sentences = @paper.sentences
    @all_count = 0
    @sentences.each do |sentence|
      sentence.s_words.each do |word|
        word.update(memorized_ch: 0)
      end
      @all_count += sentence.s_words.active.count
    end
    @progress_ch = 0
    @memorized_count_ch = 0
  end

  def waiting
    @paper = Paper.find(paper_id_params)
    @paper.waiting!
  end

  def working
    @paper = Paper.find(paper_id_params)
    @paper.working!
  end

  def review_needed
    @paper = Paper.find(paper_id_params)
    @paper.review_needed!
  end

  def completed
    @paper = Paper.find(paper_id_params)
    @paper.completed!
  end


private
  def create_params
    params.require(:paper).permit(:name).merge(user_id: current_user.id, modified_at: Time.now, status: 10)
  end
  def update_params
    params.require(:paper).permit(:name).merge(modified_at: Time.now)
  end

  def sentences_attribute_params(paper_id)
    array = []
    sentences = params[:paper][:sentences_attributes]
    if sentences.present?
      sentences.each do |key,value|
        if value["ja"].present? && value["ch"].present?
          value[:paper_id] = paper_id
          value[:pin] = get_pinyin(value[:ch])
          value[:id] = key.to_i
          array << value
        else
          next
        end
      end
    end
    return array
  end

  def words_attribute_params(paper_id)
    array = []
    words = params[:paper][:s_words_attributes]
    if words.present?
      words.each do |key,value|
        if value["ja"].present? && value["ch"].present?
          value[:paper_id] = paper_id
          value[:pin] = get_pinyin(value[:ch])
          value[:id] = key.to_i
          array << value
        else
          next
        end
      end
    end
    return array
  end

end
