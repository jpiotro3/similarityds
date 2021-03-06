class ApplicationController < ActionController::Base
  include HttpAcceptLanguage::AutoLocale

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

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  def logged_in?
    not current_user.nil?
  end

  def require_admin
    unless admin?
      redirect_to (request.referer.nil? ? root_path : :back),
                  flash: {error: I18n.t(:access_prohibited)}
    end
  end

  def require_user
    unless logged_in?
      session[:path] = request.original_fullpath
      redirect_to login_path,
                  flash: {error: I18n.t(:you_must_be_logged_in)}
    end
  end

end
