class PagesController < ApplicationController
  def home
    @events = Event.order(start_date: :desc).limit(5)
  end
end
