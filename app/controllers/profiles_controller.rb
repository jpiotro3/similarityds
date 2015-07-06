class ProfilesController < ApplicationController
  before_action :require_user, only: [:destroy, :edit, :show, :update]

# @TODO send mails
# @TODO password recovery
# @TODO password change
# @TODO view cleanups
# @TODO i18n
# @TODO add tests
# @TODO add avatars
# @TODO require unique e-mail

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'Profile created. Welcome on board!'
      redirect_to root_path
    else
      flash.now[:error] = 'Could not create a new profile!'
      render action: :new
    end
  end

  def destroy
    @user = current_user
    if @user.destroy!
      session[:user_id] = nil
      flash[:success] = 'Your profile has been successfully deleted.'
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
      flash[:success] = 'Profile updated!'
      redirect_to profile_path
    else
      flash.now[:error] = 'Could not update your profile!'
      render action: :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :first_name, :last_name, :nickname,
                                 :use_full_name, :incl_in_thesis,
                                 :incl_in_rankings)
  end

end
