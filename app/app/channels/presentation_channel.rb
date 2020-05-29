class PresentationChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    # slide = Slides.find(params[:slide_id])
    # stream_for slide
    stream_from "room1"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
