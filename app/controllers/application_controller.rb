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
    unless admin?
      redirect_to (request.referer.nil? ? root_path : :back),
                  flash: {error: 'Access prohibited!'}
    end
  end

  def require_user
    unless logged_in?
      session[:path] = request.original_fullpath
      redirect_to login_path,
                  flash: {error: 'You must be logged in to access this section!'}
    end
  end
  
end
