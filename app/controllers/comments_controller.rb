class CommentsController < ApplicationController
  before_filter :require_user

  def create
    commentable_id = params[:comment][:commentable_id]
    commentable_type = params[:comment][:commentable_type]
    body = params[:comment][:body]
    comment = Comment.build_from(commentable_id, commentable_type, current_user, body)
    comment.save!

    destination = calculate_destination(commentable_type, commentable_id)

    redirect_to destination
  end

  private
  def calculate_destination(commentable_type, commentable_id)
    destination = event_url(commentable_id) if commentable_type == Event.to_s
  end
end
