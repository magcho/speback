class SlidesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def show
    # @slide = Slide.find(params[:id])
    # @page = Page.find_by(slide_id: @slide.id, page_num: 0)
    # @user = @slide.user

    # @nextPage = Page.find_by(slide_id: @slide.id, page_num: 1) if Page.find_by(slide_id: @slide.id, page_num: 1)
    # render 'pages/show'

    redirect_to slide_page_path(params[:id], 0)
  end

  def new
    @slide = Slide.new()
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

  private 
    def slide_params
      params.require(:slide).permit(:title, :originfile_path, :start_at, :close_at, :summary, :draft)
    end
end
