class Api::V1::PresentersController < ApplicationController
  protect_from_forgery unless: :page_change

  def page_change
    @slide = Slide.find_by(token: params[:token])
    if @slide.nil?
      render json: { message: 'token error' }, status: 443
      return
    end

    broadcast_data = {
      'mode' => 'page',
      'page_num' => params[:page_num],
    }
    ActionCable.server.broadcast "presentation_#{params[:slide_id]}",
                                 broadcast_data

    @slide = Slide.find(params[:slide_id])
    @slide.update(livecast: true, current_presenter_page_num: params[:page_num])
    @slide.save

    payload = {
      'mode' => 'page',
      'page_num' => params[:page_num],
      'slide_id' => params[:slide_id],
    }
    render json: payload
  end
end
