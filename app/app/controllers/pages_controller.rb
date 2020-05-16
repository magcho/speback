class PagesController < ApplicationController
  def create
  end

  def show
    @slide = Slide.find(params[:slide_id])
    @page = Page.find_by(slide_id: @slide.id, page_num: params[:id])
    @user = @slide.user

    Miro.options[:color_count] = 1
    rgb = Miro::DominantColors.new(@page.img.path).to_hex
    @dominantColor = rgb[0]

    @previousPage = Page.find_by(slide_id: @slide.id, page_num: params[:id].to_i - 1) if Page.find_by(slide_id: @slide.id, page_num: params[:id].to_i  - 1)
    @nextPage = Page.find_by(slide_id: @slide.id, page_num: params[:id].to_i + 1) if Page.find_by(slide_id: @slide.id, page_num: params[:id].to_i  + 1)
  end

end
