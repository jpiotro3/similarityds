class SessionController < ApplicationController

  # @TODO add google and facebook signup
  # @TODO add flashes
  # @TODO add tests

  def create
    @user = User.find_by_emails(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      reset_session
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def new
    # empty
  end

end
