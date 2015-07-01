class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to new_user_path
    end
  end

  def new
    @user = User.new
  end

  def show
    # @todo
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :nickname,
                                 :use_full_name, :incl_in_thesis, :incl_in_rankings)
  end
end
