class ProfileController < ApplicationController
  before_action :require_user, only: [:destroy, :edit, :show, :update]

# @TODO add flashes
# @TODO add erb templates
# @TODO send mails
# @TODO password recovery
# @TODO password change
# @TODO view cleanups
# @TODO i18n
# @TODO add tests

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to new_profile_path
    end
  end

  def destroy
    @user = current_user
    if @user.destroy!
      session[:user_id] = nil
      redirect_to root_path
    end
  end

  def edit
    @user = current_user
  end

  def new
    @user = User.new
  end

  def show
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update!(user_params)
      redirect_to profile_path
    else
      redirect_to edit_profile_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :nickname,
                                 :use_full_name, :incl_in_thesis, :incl_in_rankings)
  end

end
