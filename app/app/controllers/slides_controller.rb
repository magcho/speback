class SlidesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def show
    @slide = Slide.find(params[:id])
  end

  def new
    @slide = Slide.new()
  end

  def create
    # @slide = Slide.create(slide_params)
    @slide = current_user.slides.build(slide_params)

    logger.debug(@slide.inspect)
    if @slide.save
      redirect_to root_path
      flash[:success] = '成功'
    else
      flash[:error] = '保存失敗'
      render 'new'
      # redirect_to new_slide_path
    end
  end

  private 
    def slide_params
      params.require(:slide).permit(:title, :originfile_path, :start_at, :close_at, :summary, :draft)
    end
end
