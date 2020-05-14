class PagesController < ApplicationController
  def create
  end

  def show
    @slide = Slide.find(params[:slide_id])
    @page = Page.find_by(slide_id: @slide.id, page_num: params[:id])
  end

end
