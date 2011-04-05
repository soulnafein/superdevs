class LinksController < ApplicationController
  layout 'new_application'

  def index
    @links = Link.get_latest
  end
end