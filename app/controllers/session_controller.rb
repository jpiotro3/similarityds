class SessionController < ApplicationController
  # @TODO add google and facebook signup
  # @TODO add tests

  def create
    @session = Session.new(session_params)
    if @session.valid?
      user = User.find_by_email(@session.email)
      if user && user.authenticate(@session.password)
        url = session[:path] || root_path
        reset_session
        session[:user_id] = user.id
        redirect_to url, notice: I18n.t(:you_have_successfully_logged_in)
      else
        @session = Session.new
        flash.now[:error] = I18n.t :login_failed
        render action: 'new'
      end
    else
      @session.password = ''
      render action: 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: I18n.t(:you_have_successfully_logged_out)
  end

  def new
    @session = Session.new
  end

  private
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
