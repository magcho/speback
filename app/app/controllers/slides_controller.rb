# coding: utf-8
class SlidesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def show
    @slide = Slide.find(params[:id])

    # プレゼン中であればプレゼンターと同じページに遷移
    if @slide.livecast
      redirect_to slide_page_path(@slide, @slide.current_presenter_page_num)
    else
      # プレゼン中でなければ最初から
      redirect_to slide_page_path(@slide, 0)
    end
  end

  def new
    @slide = Slide.new
  end

  def create
    @slide = current_user.slides.build(slide_params)
    if @slide.save
      SlidePagesJob.perform_later(@slide.id)

      # redirect_to root_path
      redirect_to slide_page_path(@slide, 0)
      flash[:success] = '成功'
    else
      flash[:error] = '保存失敗'
      redirect_to new_slide_path
    end
  end

  def fetch_comment
    @slide = Slide.find(params[:slide_id])
    if @slide.event_id
      @event = Event.where(id: @slide.event_id).first
      query = []
      @event.hashtags.each do |hashtag|
        query.push(hashtag.name)
      end
      render json: getTweets(query)
    else
      render json: { message: 'no event' }
    end
  end

  def get_token
    @slide = Slide.find(params[:slide_id])
    render json: { token: @slide.token }, status: 200
  end

  private

  def slide_params
    params.require(:slide).permit(:title, :originfile_path, :start_at, :close_at, :summary, :draft)
  end

  # hashtagsの含まれるツイートをapiで取得しCommentに追加
  def getTweets(hashtags)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_API_KEY']
      config.consumer_secret = ENV['TWITTER_API_SECRET']
    end
    hashtags.map! { |hashtag| '#' + hashtag }
    query = "(#{hashtags.join(' AND ')}) -filter:replies"

    res = client.search(query, { count: 100, result_type: 'recent', exclude: 'retweets' })

    page_id = 14 # 開発用仮の対象指定

    res.each do |tweet|
      text = tweet.full_text.to_s
      hashtags.each do |hashtag|
        text = text.gsub('#' + hashtag.to_s, '') # want fix
      end
      text = text.gsub(/^\s+/, '')

      @comment = Comment.new(text: text, page_id: page_id, tweet_id: tweet.id)
      @comment.icon_url = tweet.user.profile_image_url().to_s if tweet.user.profile_image_url?
      @comment.save
    end
  end
end
