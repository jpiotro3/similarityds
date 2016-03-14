class ProfilesController < ApplicationController
  before_action :require_user, only: [:change_password,
                                      :change_password_submit,
                                      :destroy, :edit, :show, :update]

# @TODO send mails
# @TODO password recovery
# @TODO add tests
# @TODO add avatars
# @TODO require unique e-mail

  def change_password
    @pass_form = ChangePasswordForm.new(current_user)
  end

  def change_password_submit
    @pass_form = ChangePasswordForm.new(current_user)
    if @pass_form.submit(pass_form_params)
      redirect_to profile_path, flash: {success: t(:password_changed) }
    else
      render action: :change_password
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      session[:user_id] = @user.id
      redirect_to root_path, flash: {success: t(:profile_created)}
    else
      flash.now[:error] = t :could_not_create_profile
      render action: :new
    end
  end

  def destroy
    @user = current_user
    if @user.destroy!
      reset_session
      redirect_to root_path, flash: {error: t(:profile_deleted)}
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
    if @user.update!(user_edit_params)
      redirect_to profile_path, flash: {success: t(:profile_updated) }
    else
      flash.now[:error] = t :could_not_update_profile
      render action: :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def user_edit_params
    params.require(:user).permit(:email, :first_name, :last_name, :nickname,
                                 :incl_in_thesis, :incl_in_rankings,
                                 :use_full_name)
  end

  def pass_form_params
    params.require(:change_password_form).permit(:old_password, :password,
                                                 :password_confirmation)
  end
end
