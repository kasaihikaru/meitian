class PassagesController < ApplicationController
  before_action :login_check, except: [:word_ja, :word_ch]


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
      if w[:id].present?
        original_word = PWord.find(w[:id])
        if original_word.pin_fixed == true
          original_word.update(ja: w[:ja], ch: w[:ch])
        else
          original_word.update(ja: w[:ja], ch: w[:ch], pin: w[:pin])
        end
      else
        PWord.create(ja: w[:ja], ch: w[:ch], pin: w[:pin], passage_id: passage.id)
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

#-----------------------ストロングパラメーター-----------------------
private

  def passage_id_params
    params[:passage_id].to_i
  end

  def create_params
    params.require(:passage).permit(:title, :ja, :ch).merge(user_id: current_user.id, modified_at: Time.now)
  end

  def words_attribute_params(passage_id)
    array = []
    words = params[:passage][:p_words_attributes]
    if words.present?
      words.each do |key,value|
        if value["ja"].present? && value["ch"].present?
          value[:passage_id] = passage_id
          value[:pin] = get_pinyin(value[:ch])
          array << value
        else
          next
        end
      end
    end
    return array
  end

  def add_new_words_params
    params.require(:new_words)
  end


#-----------------------validation系-----------------------

end
