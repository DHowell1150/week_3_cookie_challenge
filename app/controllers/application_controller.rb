class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @_current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  # cookies.signed.permanent[:location] = params[:location]
  # cookies[:key ] = {
  #   location: params[:location],
  #   expires: 20.years.from_now
  # }
end
