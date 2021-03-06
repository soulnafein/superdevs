class CodeSnippetsController < ApplicationController
  before_filter :require_user, :only => [:create]

  def index
    @code_snippets = CodeSnippet.get_latest
  end

  def show
    @code_snippet = CodeSnippet.find(params[:id])
  end

  def create
    @code_snippet = CodeSnippet.new(params['code_snippet'])
    @code_snippet.author = current_user
    @code_snippet.save!
    redirect_to code_snippets_url
  rescue ActiveRecord::RecordInvalid
    @link = Link.new
    render :action => 'posts/new'
  end
end