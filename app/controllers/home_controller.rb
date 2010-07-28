class HomeController < ApplicationController
  def index
    if current_user
      @events = Event.get_events_for_user(current_user)
      render "user_home", :layout => "application"
    end
  end
end
