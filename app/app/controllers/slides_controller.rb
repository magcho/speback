class SlidesController < ApplicationController
  def show
    @slide = Slide.find(params[:id])
  end

  def new
    @slide = Slide.new()
  end
end
