class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :restrict_access, :only => [:fetch, :add, :index]

  private

  def restrict_access
    api_key = ApiKey.find_by_access_token(params[:access_token])
    head :unauthorized unless api_key
  end

  def current_developer
    @current_developer ||= Developer.find(session[:developer_id]) if session[:developer_id]
  end
  helper_method :current_developer
  
end
