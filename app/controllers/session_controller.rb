class SessionController < ApplicationController

  # @TODO add google and facebook signup
  # @TODO add tests

  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      reset_session
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'You have successfully logged in. Welcome back!'
    else
      flash.now[:error] = 'Incorrect email or password!'
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
