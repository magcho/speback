class Api::V1::PresentationController < ApplicationController
  before_action :check_parms, only: [:status]
  protect_from_forgery unless: :status

  def status
    @slide = Slide.find_by(token: params[:token])
    if @slide.nil?
      render json: { message: 'token error' }, status: 443
      return
    end

    if (params[:status] == 'ready')
      render json: { message: 'ready' }, status: 200
    elsif (params[:status] == 'start')
      @slide.update(livecast: true, current_presenter_page_num: 0)
      if @slide.save
        render json: { message: 'start' }, status: 200
      else
        render json: { message: 'error' }, status: 500
      end
      
    elsif (params[:status] == 'finish')
      @slide.update(current_presenter_page_num: 0, livecast: false)
      if @slide.save
        render json: { message: 'finish' }, status: 200
      else
        render json: { message: 'error' }, status: 500
      end
    end

    return
  end

  private

  def check_parms
    if params[:token].nil? or params[:status].nil?
      render json: { message: 'params error' }
    end
  end
end
