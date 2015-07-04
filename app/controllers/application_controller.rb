class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :flash_class, :flash_header, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def flash_class(key)
    case key
      when 'success' then 'alert-success'
      when 'notice'  then 'alert-info'
      when 'alert'   then 'alert-warning'
      when 'error'   then 'alert-danger'
      else 'alert-info'
    end
  end

  def flash_header(key)
    case key
      when ':success' then 'Success!'
      when 'notice'   then ''
      when 'alert'    then 'Warning!'
      when 'error'    then 'Error!'
      else ''
    end
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
