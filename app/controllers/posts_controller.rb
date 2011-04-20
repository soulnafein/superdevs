class PostsController < ApplicationController
  before_filter :require_user, :only => [:new]
  def new
    @link = Link.new
    @code_snippet = CodeSnippet.new
    render :layout => 'application'
  end
end
