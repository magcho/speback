class PagesController < ApplicationController
  include PagesHelper
  def create
  end

  def show
    @slide = Slide.find(params[:slide_id])
    @page = Page.find_by(slide_id: @slide.id, page_num: params[:id])
    @comment = Comment.new

    Miro.options[:color_count] = 1
    rgb = Miro::DominantColors.new(@page.img.path).to_hex
    @dominant_color = rgb[0]

    
    # @even= ignore_current_slide_filter(Event.find(@slide.event_id).slides, @slide)
    # logger.debug(@related_slides)

    @related_slides = Slide.where(event_id: @slide.event_id).where.not(id: @slide.id)
    # @related_slides = Event.find(@slide.event_id).slides

    @previousPage = Page.find_by(slide_id: @slide.id, page_num: params[:id].to_i - 1) if Page.find_by(slide_id: @slide.id, page_num: params[:id].to_i  - 1)
    @nextPage = Page.find_by(slide_id: @slide.id, page_num: params[:id].to_i + 1) if Page.find_by(slide_id: @slide.id, page_num: params[:id].to_i  + 1)
  end

end
