class Api::V1::PresentationController < ApplicationController
  before_action :check_parms, only:[:status]
  protect_from_forgery unless: :status

  def status
    unless check_token
      render json: {message: 'token error'},status: 443
    end

    if(params[:status]== 'ready')
      

      render json: {message:'ready'}
    elsif(params[:status] == 'start')
      @slide = Slide.find(params[:slide_id])
      @slide.update(livecast: true, current_presenter_page_num: 0)
      if @slide.save
        render json: {message: 'start'}
      end
      return
    elsif(params[:status] == 'finish')

      @slide = Slide.find(params[:slide_id])
      @slide.update(current_presenter_page_num: 0, livecast: false)
      if @slide.save
        render json: {message: 'finish'}
      else
        render json: {message: 'fatal'}
      end
      return
    end

    return
  end

  private

  def check_token
    params[:token] == 'aabbcc'
  end

  def check_parms
    if params[:token].nil? or params[:status].nil? or params[:slide_id].nil?
      render json: {message: 'params error'}
    end
  end

end
