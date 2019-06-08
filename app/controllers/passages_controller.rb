class PassagesController < ApplicationController
  before_action :login_check, except: [:word_ja, :word_ch]
  before_action -> {
    user_check_by_id(get_user_by_id_for_passage)
  },only: [:edit, :update, :destroy]
  before_action -> {
    user_check_by_id(get_user_by_passage_id_for_passage)
  },only: [:uncheck_all_words_ja, :uncheck_all_words_ch, :waiting, :working, :review_needed, :completed]


  def new
    @passage = Passage.new
    @passage.p_words.build
  end

  def edit
    @passage = Passage.find(id_params)
  end


#-----------------passage show-----------------------
  def get_for_passage_show
    @passage = Passage.find(passage_id_params)
    @user = @passage.user
    @words = @passage.p_words.active
    if @words.present?
      @unmemorized_words_ch_count = @words.unmemorized_ch.count
      @unmemorized_words_ja_count = @words.unmemorized_ja.count
      @all_words_count = @words.count
      @memorized_words_ch_count = @all_words_count - @words.unmemorized_ch.count
      @progress = 100 * @memorized_words_ch_count / @all_words_count
    end
  end

  def word_ja
    get_for_passage_show
  end

  def word_ch
    get_for_passage_show
  end

#-----------------------post, put-----------------------
  def create
    passage = Passage.create(create_params)

    # 付属の単語作成
    words = words_attribute_params(passage.id)
    words.each do |w|
      PWord.create("ja"=>w[:ja], "ch"=>w[:ch], "pin"=>w[:pin], "passage_id"=>w[:passage_id])
    end

    redirect_to passage_word_ch_path(passage.id)
  end

  def update
    # 文章更新
    passage = Passage.find(id_params)
    passage.update(title:create_params[:title], ja:create_params[:ja], ch:create_params[:ch], modified_at: create_params[:modified_at])

    # 単語更新
    words = words_attribute_params(passage.id)
    words.each do |w|
      original_word = PWord.find(w[:id])
      if original_word.pin_fixed == true
        original_word.update(ja: w[:ja], ch: w[:ch])
      else
        original_word.update(ja: w[:ja], ch: w[:ch], pin: w[:pin])
      end
    end

    # 新規word追加
    add_new_words_params.each do |w|
      if w[:ja].present? && w[:ch].present?
        pinyin = get_pinyin(w[:ch])
        PWord.create(ja: w[:ja], ch: w[:ch], passage_id: passage.id, pin: pinyin)
      end
    end

    redirect_to passage_word_ch_path(passage.id)
  end

  def destroy
    passage = Passage.find(id_params)
    passage.update(deleted_at: Time.now)
    passage.p_words.each do |word|
      word.update(deleted_at: Time.now)
    end

    redirect_to user_passages_path(current_user)
  end

  def copy
    passage_id = Passage.find(passage_id_params).id
    user_id = current_user.id
    copy_specific_passage(passage_id, user_id, false)
    @msg = "自分の文章として保存しました。"
  end

  def uncheck_all_words_ja
    passage = Passage.find(passage_id_params)
    passage.p_words.each do |word|
      word.update(memorized_ja: 0)
    end

    redirect_to passage_word_ja_path(passage)
  end

  def uncheck_all_words_ch
    passage = Passage.find(passage_id_params)
    passage.p_words.each do |word|
      word.update(memorized_ch: 0)
    end

    redirect_to passage_word_ch_path(passage)
  end

  def waiting
    @passage = Passage.find(passage_id_params)
    @passage.waiting!
  end

  def working
    @passage = Passage.find(passage_id_params)
    @passage.working!
  end

  def review_needed
    @passage = Passage.find(passage_id_params)
    @passage.review_needed!
  end

  def completed
    @passage = Passage.find(passage_id_params)
    @passage.completed!
  end

#-----------------------ストロングパラメーター-----------------------
private
  def create_params
    params.require(:passage).permit(:title, :ja, :ch).merge(user_id: current_user.id, modified_at: Time.now, status: 10)
  end

  def words_attribute_params(passage_id)
    array = []
    words = params[:passage][:p_words_attributes]
    if words.present?
      words.each do |key,value|
        if value["ja"].present? && value["ch"].present?
          value[:passage_id] = passage_id
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


#-----------------------validation系-----------------------

end
