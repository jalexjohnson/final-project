class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?
  helper_method :current_user
  
  def require_login
    redirect_to root_url, notice: "Please login." unless logged_in?
  end

  def logged_in?
    session[:user_id]
  end

  def current_user
    User.find_by_id(session[:user_id])
  end

end
