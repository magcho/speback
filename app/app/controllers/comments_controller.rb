class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    text = params[:text].gsub(/#\S*\s+/,'')
    @comment = current_user.comments.build(text: text)
    @comment.page = Page.find_by(slide: params[:slide_id], page_num: params[:page_num])
    
    postTweet(params[:text])

    if @comment.save
      # flash[:success] = "コメントを投稿しました"
      
      event = Event.find(Slide.find(params[:slide_id]).event_id)
      if event.hashtags.any?
        hashtags = event.hashtags.map do |hashtag|
          hashtag.name
        end
        payload = {
          "hashtags" => hashtags,
          "message" => {
            "message" => "success"
          }
        }
        render json: payload, status: 200

      else
        render json: {message: 'success'}, status: 200
        # render root_path
      end
    else
      # flash[:error] = "コメントの投稿に失敗しました"
      render json: {message: 'error'}, status: 422
    end
  end
  
  

  private
  def comment_params
    params.permit(:text)
  end
  
  # ツイートする
  def postTweet(text)
    if text.length <= 120
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_API_KEY']
        config.consumer_secret     = ENV['TWITTER_API_SECRET']
        config.access_token        = session[:access_token]
        config.access_token_secret = session[:access_token_secret]
      end
      return client.update(text)
    else
      return false
    end
  end
end
