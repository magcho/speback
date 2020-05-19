class StaticPagesController < ApplicationController
  def home
    @events = Event.all
  end

  def help
  end

  def guide
  end
end
