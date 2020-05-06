class SessionsController < ApplicationController
  include SessionsHelper

  #ログイン画面
  def new
  end

  # auth apiからのコールバック
  def create
    unless request.env['omniauth.auth'][:uid]
      flash[:danger] = '連携に失敗しました'
      redirect_to root_url
    end
    user_data = request.env['omniauth.auth']
    user = User.find_by(twitter_uid: user_data[:uid])
    if user #既存ユーザーチェック
      log_in user
      flash[:success] = user.name + 'でログインしました'
      redirect_to root_url
    else
      new_user = User.new(
        twitter_uid: user_data[:uid],
        twitter_id: user_data[:info][:nickname],
        name: user_data[:info][:name],
        icon_path: user_data[:info][:image],
      )
      if new_user.save
        log_in new_user
        flash[:success] = 'ユーザー登録成功'
      else
        flash[:danger] = '予期せぬエラーが発生しました'
      end
      redirect_to root_url
    end
  end


  def destroy
    log_out if logged_in?
    flash[:success] = 'ログアウトしました'
    redirect_to root_url
  end
end