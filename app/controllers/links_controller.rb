class LinksController < ApplicationController
  before_filter :require_user, :only => [:new, :create]
  layout 'new_application'

  def index
    @links = Link.get_latest
  end

  def new
    @link = Link.new
    render :layout => 'application'
  end

  def create
    @link = Link.new(params['link'])
    @link.author = current_user
    @link.save!
    redirect_to links_url
  rescue ActiveRecord::RecordInvalid
    render :action => :new, :layout => 'application'
  end
end