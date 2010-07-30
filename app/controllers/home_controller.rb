require_dependency 'user_events'
class HomeController < ApplicationController
  def index
    if current_user
      @user_events = get_user_events_for_city
      @user_events = get_user_events_for_country if @user_events.empty?
      render "user_home", :layout => "application"
    end
  end

  private
  def get_user_events_for_city
    UserEvents.new(:events => Event.get_events_for_user_city(current_user),
                   :location => current_user.location)
  end

  def get_user_events_for_country
    UserEvents.new(:events => Event.get_events_for_user_country(current_user),
                   :location => current_user.country)
  end
end
