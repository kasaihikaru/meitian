class SentencesController < ApplicationController
  before_action :login_check
  #-----------------------get-----------------------
  def new
    @sentence = Sentence.new
    @sentence.s_words.build
    @mypapers = current_user.papers.active
  end

  def edit
  end

  def edit_pin
  end

  #-----------------------post, put-----------------------
  def create
    # 短文作成
    sentence = Sentence.create(create_sentence_params)

    # 付属の単語作成
    words = words_attribute_params(sentence.id)
    words.each do |w|
        SWord.create("ja"=>w[:ja], "ch"=>w[:ch], "pin"=>w[:pin], "sentence_id"=>w[:sentence_id])
    end

    # paperを最新化
    sentence.paper.update(modified_at: Time.now)

    #リダイレクト
    redirect_to paper_sentence_ch_path(sentence.paper.id)
  end

  def update
  end

  def destroy
  end

  def copy
  end

  def check_ja
    @sentence = Sentence.find(sentence_id_params)
    @sentence.update( memorized_ja: 1 )
  end

  def check_ch
    @sentence = Sentence.find(sentence_id_params)
    @sentence.update( memorized_ch: 1 )
  end

  def uncheck_ja
    @sentence = Sentence.find(sentence_id_params)
    @sentence.update( memorized_ja: 0 )
  end

  def uncheck_ch
    @sentence = Sentence.find(sentence_id_params)
    @sentence.update( memorized_ch: 0 )
  end

  def update_pin
  end


  private
  #-----------------------ストロングパラメーター-----------------------
  def create_sentence_params
      pinyin = get_pinyin(params[:sentence][:ch])
      params.require(:sentence).permit(:paper_id, :ja, :ch).merge(pin: pinyin)
  end
  def words_attribute_params(sentence_id)
    array = []
    words = params[:sentence][:s_words_attributes]
    if words.present?
      words.each do |key,value|
        if value["ja"].present? && value["ch"].present?
          value[:sentence_id] = sentence_id
          value[:pin] = get_pinyin(value[:ch])
          array << value
        else
          next
        end
      end
    end
    return array
  end

  def update_sentence_params
      pinyin = get_pinyin(params[:sentence][:ch])
      params.require(:sentence).permit(:ja, :ch).merge(pin: pinyin)
  end
  def update_new_words_params
      params.require(:new_words)
  end
end
