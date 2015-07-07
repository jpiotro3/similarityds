class SessionController < ApplicationController
  # @TODO add session model and validation
  # @TODO add google and facebook signup
  # @TODO redirect to prev page
  # @TODO add tests
  # @TODO i18n

  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      url = session[:path] || root_path
      reset_session
      session[:user_id] = @user.id
      redirect_to url, notice: 'You have successfully logged in. Welcome back!'
    else
      flash.now[:error] = 'Log in failed! Incorrect email or password.'
      render action: 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'You have successfully logged out!'
  end

  def new
    # empty
  end

end
