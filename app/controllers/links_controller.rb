class LinksController < ApplicationController
  before_filter :require_user, :only => [:create]

  def index
    @links = Link.get_latest
  end

  def show
    @link = Link.find(params[:id])
  end


  def create
    @link = Link.new(params['link'])
    @link.author = current_user
    @link.save!
    redirect_to links_url
  rescue ActiveRecord::RecordInvalid
    @code_snippet = CodeSnippet.new
    render :action => 'posts/new'
  end
end