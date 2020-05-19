class EventsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  def show
    @event = Event.find(params[:id])
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
          @hashtag = Hashtag.new(name: hashtag.gsub('#','').gsub(' ',''), event_id: @event.id)
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

  def edit
    @event = Event.find(params[:id])
    hashtags = Hashtag.where(event_id: params[:id])
    @hashtags = hashtags_to_oneline(hashtags)
    
  end
    
  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)

      # 編集前のタグたちとの差分をとる、差分はdestroy, createする
      old_hashtags = []
      Hashtag.where(event_id: params[:id]).each do |hashtag|
        old_hashtags.append(hashtag.name)
      end

      new_hashtags = oneline_to_array(params[:hashtags])

      p old_hashtags
      p new_hashtags
      delete_tags = old_hashtags - new_hashtags
      if delete_tags.any?
        delete_tags.each do |tag|
          Hashtag.find_by(name: tag).destroy
        end
      end

      create_tags = new_hashtags - old_hashtags
      if create_tags.any?
        create_tags.each do |tag|
          new_tag = @event.hashtags.build(name: tag)
          new_tag.save
        end
      end
      
      flash[:success] = "イベント情報を更新しました"
      redirect_to @event
    else
      render 'edit'
    end
  end


  private
    def event_params
      params.require(:event).permit(:name, :start_at, :close_at, :coverimg_path, :link)
    end

    def hashtags_to_oneline(hashtags)
      tagArr = []
      if hashtags
        hashtags.each do |hashtag|
          tagArr.append('#' + hashtag.name)
        end
      end
      tagArr.sort!
      tagArr.join(',')
    end

    def oneline_to_array(oneline)
      arr = oneline.split(',')
      arr.map! do |tag|
        tag.gsub('#','').gsub(' ','')
      end
      arr
    end
end
  
  




