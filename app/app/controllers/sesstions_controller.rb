class SesstionsController < ApplicationController
  def index
    rendrer
  end
  def show
  end

  def create
    unless request.env['omniauth.auth'][:uid]
      flash[:danger] = '連携に失敗しました'
      redirect_to root_url
    end

    user_data = request.env['omniauth.auth']
    user = User.find_by(uid: user_data[:uid])
    if user
      log_in user
      flash[:success] = 'ログインしました'
      redirect_to root_url
    else
      new_user = User.new(
        uid: user_data[:uid],
        name: user_data[:info][:name],
        icon_path: user_data[:info][:image]
      )
      if new_user.save
        log_in new_user
        flash[:success] = 'ようこそ' 
      else
        flash[:danger] = "ユーザー登録できませんでした"
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
