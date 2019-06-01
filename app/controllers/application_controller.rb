class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image, :introduction, :goal, :link])
  end


# ----------バリデーション-------------
	def login_check
		unless user_signed_in?
			flash[:alert] = 'ログインすると便利に利用できます！'
			redirect_to explore_path
		end
	end

	def user_check_by_id(user_id)
		unless user_signed_in? && user_id == current_user.id
			flash[:alert] = "自分の投稿のみ編集できます"
			redirect_to root_path
		end
	end

	def get_user_by_passage_id_for_passage
		Passage.find(passage_id_params).user_id
	end
	def get_user_by_id_for_passage
		Passage.find(id_params).user_id
	end
	def get_user_by_paper_id_for_paper
		Paper.find(paper_id_params).user_id
	end
	def get_user_by_id_for_paper
		Paper.find(id_params).user_id
	end
	def get_user_by_p_word_id_for_p_word
		PWord.find(p_word_id_params).passage.user_id
	end
	def get_user_by_id_for_p_word
		PWord.find(id_params).passage.user_id
	end
	def get_user_by_sentence_id_for_sentence
		Sentence.find(sentence_id_params).paper.user_id
	end
	def get_user_by_id_for_sentence
		Sentence.find(id_params).paper.user_id
	end
	def get_user_by_s_word_id_for_s_word
		SWord.find(s_word_id_params).sentence.paper.user_id
	end
	def get_user_by_id_for_s_word
		SWord.find(id_params).sentence.paper.user_id
	end
	def get_user_by_ring_id_for_ring
		Ring.find(ring_id_params).user_id
	end
	def get_user_by_id_for_ring
		Ring.find(id_params).user_id
	end
	def get_user_by_r_word_id_for_r_word
		RWord.find(r_word_id_params).ring.user_id
	end
	def get_user_by_id_for_r_word
		RWord.find(id_params).ring.user_id
	end


#---------共通処理--------------
	def get_pinyin(ch)
		pin = PinYin.of_string(ch, :unicode)
		if pin.count == 1
			pinyin = pin.first
		else
			pinyin = ""
			pin.each do |p|
				pinyin += "#{p} "
			end
		end
		return pinyin
	end

	def get_user_theme
		@this_month = Date.today.month.to_s
		theme = @user.themes.this_month.first
		if theme.present?
			@theme = theme.theme
		else
			@theme = ''
		end
	end


	def get_recent_prs_list
		@passages = @user.passages.active.recent
		@papers = @user.papers.active.recent
		@rings = @user.rings.active.recent
	end

	def get_psr_counts
		@passages_cnt = @user.passages.active.count
		@papers_cnt = @user.papers.active.count
		@rings_cnt = @user.rings.active.count
	end

	def get_new_paper_ring
		@paper = Paper.new
		@ring = Ring.new
	end


#-----------------------コピー-----------------------
  # サンプル文章作成用
  def copy_specific_passage(passage_id, user_id)
    # 文章作成
    passage = Passage.find(passage_id)
    new_passage = Passage.create(title: passage.title, ja:passage.ja, ch: passage.ch, user_id: user_id, modified_at: Time.now)

    # 付属単語作成
    words = passage.p_words
    words.each do |w|
      PWord.create(ja: w[:ja], ch: w[:ch], pin: w[:pin], passage_id: new_passage.id)
    end
  end

  # サンプル短文集作成用
  def copy_specific_paper(paper_id, user_id)
    # 短文集作成
    paper = Paper.find(paper_id)
    new_paper = Paper.create(name: paper.name, user_id: user_id, modified_at: Time.now)

    # 付属短文作成
    sentences = paper.sentences
    sentences.each do |sentence|
      new_sentence = Sentence.create(ja: sentence[:ja], ch: sentence[:ch], pin: sentence[:pin], paper_id: new_paper.id)

      # 付属単語作成
      words = sentence.s_words
      words.each do |w|
        SWord.create(ja: w[:ja], ch: w[:ch], pin: w[:pin], sentence_id: new_sentence.id)
      end
    end
  end

  # サンプル単語帳作成用
  def copy_specific_ring(ring_id, user_id)
    # 単語帳作成
    ring = Ring.find(ring_id)
    new_ring = Ring.create(name: ring.name, user_id: user_id, modified_at: Time.now)

    # 付属単語作成
    words = ring.r_words
    words.each do |w|
      RWord.create(ja: w[:ja], ch: w[:ch], pin: w[:pin], ring_id: new_ring.id)
    end
  end


private
	#-----------------------strong patameter-----------------------
	def id_params
		params[:id].to_i
	end
  def user_id_params
    params[:user_id].to_i
  end
  def passage_id_params
    params[:passage_id].to_i
  end
  def p_word_id_params
    params[:p_word_id].to_i
  end
	def paper_id_params
		params[:paper_id].to_i
	end
	def sentence_id_params
		params[:sentence_id].to_i
	end
	def s_word_id_params
		params[:s_word_id].to_i
	end
	def ring_id_params
		params[:ring_id].to_i
	end
  def r_word_id_params
    params[:r_word_id].to_i
  end
	def r_word_params
		params[:r_word]
	end
	def word_id_params
		params[:word_id].to_i
	end
	def pin_params
		params[:pin]
	end
  def add_new_words_params
    params.require(:new_words)
  end
	def page_params
		params[:page].to_i
	end


end
