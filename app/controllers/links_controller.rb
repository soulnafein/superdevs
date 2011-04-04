class LinksController < ApplicationController
  def index
    @links = Link.get_latest
  end
end