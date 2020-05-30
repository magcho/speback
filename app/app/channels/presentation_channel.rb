class PresentationChannel < ApplicationCable::Channel
  def subscribed

    stream_from "presentation_#{params[:slide_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
