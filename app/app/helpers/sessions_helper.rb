module SessionsHelper
  # 渡されたユーザーでログインする
  def log_in(user)
    session[:id] = user.id
  end

  # 現在ログイン中のユーザーを返す (いる場合)
  def current_user
    if session[:id]
      @current_user ||= User.find_by(id: session[:id])
    end
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  # 現在のユーザーをログアウトする
  def log_out
    session.delete(:id)
    @current_user = nil
  end
end