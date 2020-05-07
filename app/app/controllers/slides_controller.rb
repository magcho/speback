class SlidesController < ApplicationController
  def show
    @slide = Slide.find(params[:id])
  end
end
