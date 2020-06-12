# coding: utf-8
class Api::V1::PresentersController < ApplicationController
  protect_from_forgery unless: :page_change

  def page_change
    @slide = Slide.find_by(token: params[:token])
    if @slide.nil?
      render json: { message: 'token error' }, status: 443
      return
    end

    @page = Page.find_by(slide_id: @slide, page_num: params[:page_num])
    @page_move = PageMove.find_by(page: @page)
    if @page_move
      @page_move.touch # updated_atの更新
    else
      @page_move = PageMove.new(page: @page)
      @page_move.save
    end
    

    broadcast_data = {
      'mode' => 'page',
      'page_num' => params[:page_num],
    }
    ActionCable.server.broadcast "presentation_#{@slide.id}",
                                 broadcast_data


    @slide.update(livecast: true, current_presenter_page_num: params[:page_num])
    @slide.save

    payload = {
      'mode' => 'page',
      'page_num' => params[:page_num],
      'slide_id' => @slide.id,
    }
    render json: payload
    return
  end
end
