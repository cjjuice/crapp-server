class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :restrict_access

  private

  def restrict_access
    api_key = ApiKey.find_by_access_token(params[:access_token])
    head :unauthorized unless api_key
  end
end
