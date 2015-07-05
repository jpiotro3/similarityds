class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :admin?, :current_user, :logged_in?

  def admin?
    logged_in? and current_user.admin?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    not current_user.nil?
  end

  def require_admin
    redirect_to root_path, error: 'Access prohibited!' unless current_user.admin?
  end

  def require_user
    redirect_to login_path, error: 'You must be logged in to access this section!' unless logged_in?
  end
  
end
