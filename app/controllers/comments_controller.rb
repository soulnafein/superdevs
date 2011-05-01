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
    #don't blame this code, pragmatic choice considering that
    #soon create will return json and adding comment will use ajax
    return event_url(commentable_id) if commentable_type == Event.to_s
    return link_url(commentable_id) if commentable_type == Link.to_s
    return code_snippet_url(commentable_id) if commentable_type == CodeSnippet.to_s
  end
end
