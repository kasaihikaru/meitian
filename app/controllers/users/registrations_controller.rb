# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  def after_sign_up_path_for(resource)
    # リダイレクトの関係でこっちでringサンプル作成
    copy_sample_ring(current_user.level, current_user.id)

    # リダイレクト
    ring_word_ja_path(current_user.rings.first)
  end

  # メール認証入れた場合これ。今は実質使ってない
  def after_inactive_sign_up_path_for(resource)
    # リダイレクトの関係でこっちでpassageサンプル作成
    copy_sample_passage(current_user.level, current_user.id)

    # リダイレクト
    passage_word_ch_path(current_user.passages.first)
  end

  # POST /resource
  def create
    super

    if resource.persisted?
      user = User.last

      # サンプル作成
      copy_sample_passage(user.level, user.id)
      copy_sample_paper(user.level, user.id)

      UserMailer.registration(user).deliver_now
      # redirect_to passage_word_ch_path(user.passages.first)
    end
  end

  # GET /resource/edit
  def edit
    @user = current_user
    super
  end

  # PUT /resource
  def update
    super
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
