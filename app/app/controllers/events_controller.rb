class EventsController < ApplicationController

def show
  @event = Event.find(params[:id])
  @hashtags = @event.Hashtags
end


def new
  @event = Event.new
end

end
