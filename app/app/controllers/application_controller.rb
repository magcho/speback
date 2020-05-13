class ApplicationController < ActionController::Base
  include SessionsHelper

  private

    # ユーザーのログインを確認する
    def logged_in_user
      unless logged_in?
        # store_location
        flash[:error] = "この操作を行うにはログインしてください"
        redirect_to login_path
      end
    end
end