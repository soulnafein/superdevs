class CommentsController < ApplicationController
  before_filter :require_user

  def create
    event_id = params[:event_id]
    comment = Comment.build_from(event_id, Event.to_s, current_user, params[:comment][:body])
    comment.save!
    redirect_to event_url(event_id)
  end
end
