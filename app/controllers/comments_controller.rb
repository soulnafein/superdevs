class CommentsController < ApplicationController
  before_filter :require_user

  def create
    event_id = params[:event_id]
    details = { :body => params[:comment][:body],
                :event_id => event_id,
                :author => current_user}
    Comment.create!(details)
    redirect_to event_url(event_id)
  end
end
