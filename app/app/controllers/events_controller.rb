class EventsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  def show
    @event = Event.find(params[:id])
    @hashtags = @event.Hashtags
  end
  
  def new
    @event = Event.new()
  end


  def create
    @event = Event.new(event_params)
    hashtags = params[:hashtags].split(',')

    if @event.save
      if hashtags.any?
        hashtags.map { |hashtag|
          @hashtag = Hashtag.new(name: hashtag.gsub('#',''), event_id: @event.id)
          if @hashtag.save
          else
            flash[:error] = 'ハッシュタグを保存できませんでした'
          end
        }
      end
      flash[:success] = 'イベントを登録しました'
      redirect_to @event
    else
      flash[:error] = '作成できませんでした'
      redirect_to new_event_path
    end
  end
    
  private
    def event_params
      params.require(:event).permit(:name, :start_at, :close_at, :coverimg_path, :link)
    end
end
  
  




