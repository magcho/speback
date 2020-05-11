class EventsController < ApplicationController
  include SessionsHelper

  def show
    @event = Event.find(params[:id])
    @hashtags = @event.Hashtags
  end

  def new
    unless logged_in?
      flash[:error] = 'イベントを登録するにはログインしてください。'
      redirect_to login_path
    end
  end
  



end
