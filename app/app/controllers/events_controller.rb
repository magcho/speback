class EventsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  def show
    @event = Event.find(params[:id])
    @hashtags = @event.Hashtags
  end
  
  def new
    @event = Event.new()
    # @hashtag = @event.Hashtags.build()    
  end


  def create
    @event = Event.new(event_params)
    # @event.name = params[:name]
    # @event.start_at = params[:start_at]
    logger.debug(@event.inspect)
    logger.debug(@event.valid?)
    if @event.save
      flash[:success] = 'イベントを登録しました'
      redirect_to @event
    else
      flash[:error] = '作成できませんでした。'
      redirect_to new_event_path
    end
  end
    
  private
    def event_params
      params.require(:event).permit(:name, :start_at, :close_at, :coverimg_path, :link)
    end
end
  
  




