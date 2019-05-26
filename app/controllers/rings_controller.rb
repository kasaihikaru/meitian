class RingsController < ApplicationController
  before_action :login_check, except: [:word_ja, :word_ch]
  #-----------------------get-----------------------
  def edit
  end

  def word_ja
  end

  def word_ch
  end

  #-----------------------post, put-----------------------
  def create
    Ring.create(create_params)
    redirect_to user_rings_path(current_user)
  end

  def update
  end

  def destroy
  end

  def copy
  end

  def uncheck_all_words_ja
  end

  def uncheck_all_words_ch
  end

private
  def create_params
    params.require(:ring).permit(:name).merge(user_id: current_user.id, modified_at: Time.now)
  end

end
