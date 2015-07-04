class UsersController < ApplicationController
  before_action :require_admin

  # @TODO add pagination
  # @TODO send mails
  # @TODO view cleanups
  # @TODO i18n
  # @TODO add tests
  # @TODO add avatars

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'User created.'
      redirect_to user_path(@user)
    else
      flash.now[:error] = 'Could not create a new user!'
      render action: :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy!
      flash[:success] = 'User deleted!'
      redirect_to users_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def index
    @users = User.order(:email)
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update!(user_params)
      flash[:success] = 'User updated'
      redirect_to user_path(@user)
    else
      flash.now[:error] = 'Could not update the user!'
      render action: :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :role, :first_name, :last_name, :nickname,
                                 :use_full_name, :incl_in_thesis,
                                 :incl_in_rankings)
  end

end
