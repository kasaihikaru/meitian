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

	def user_check_by_passage_id
		unless user_signed_in? && Passage.find(passage_id_params).user_id == current_user.id
			flash[:alert] = "自分の投稿のみ編集できます"
			redirect_to root_path
		end
	end

	def user_check_by_id
		unless user_signed_in? && Passage.find(id_params).user_id == current_user.id
			flash[:alert] = "自分の投稿のみ編集できます"
			redirect_to root_path
		end
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
