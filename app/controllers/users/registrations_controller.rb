# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super

    # サンプル作成
    copy_specific_passage(1, User.last.id)
    copy_specific_passage(2, User.last.id)

  end

  # GET /resource/edit
  def edit
    @user = current_user
    get_user_theme
    super
  end

  # PUT /resource
  def update
    super
    theme = current_user.themes.this_month
    if theme.blank?
      Theme.create(user_id: current_user.id, theme: theme_params, yearmonth: Date.today.beginning_of_month)
    else
      theme.first.update(theme: theme_params)
    end
  end


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

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  #user編集の際にパスワード入力をなくす
  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def theme_params
    params[:theme]
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
