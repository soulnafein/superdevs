class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'

  helper_method :current_user

  def render_404(exception = nil)
    if exception
      logger.info "Rendering 404 with exception: #{exception.message}"
    end

    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404.html", :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = PersonSession.find
  end

  def current_user
    @current_user = current_user_session && current_user_session.record
  end
end
