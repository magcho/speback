class Api::V1::PresentersController < ApplicationController
  protect_from_forgery unless: :page_change
  
  def page_change
    unless check_token
      render json: {message: 'token error'}, status: 443
      return
    end



    broadcastData={
      "mode" => "page",
      "page_num" => params[:page_num]
    }
    ActionCable.server.broadcast "presentation_#{params[:slide_id]}", broadcastData

    @slide = Slide.find(params[:slide_id])
    @slide.update(livecast: true, current_presenter_page_num: params[:page_num])
    @slide.save

    payload ={
      "mode" => "page",
      "page_num" => params[:page_num],
      "slide_id"=>params[:slide_id]
    }
    render json: payload
    return
  end

  
  private
  def check_token
    unless params[:token] == 'aabbcc'
      return false
    else 
      return true
    end
  end  
end
