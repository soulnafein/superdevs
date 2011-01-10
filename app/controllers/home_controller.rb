require_dependency 'user_events'
class HomeController < ApplicationController
  def index
    if current_user
      @user_home_presenter = UserHomePresenter.new(current_user)
      render "user_home", :layout => "application"
    end
  end
end
