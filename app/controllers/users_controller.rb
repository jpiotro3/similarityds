class UsersController < ApplicationController
  before_action :require_admin

  USERS_PER_PAGE = 50

  # @TODO test pagination
  # @TODO send mails
  # @TODO add tests
  # @TODO add avatars

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user), flash: {success: t(:user_created)}
    else
      flash.now[:error] = t :could_not_create_user
      render action: :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    deleted_self = (current_user == @user)
    if @user.destroy!
      reset_session if deleted_self
      redirect_to users_path, flash: {success: t(:user_deleted)}
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def index
    @users = User.paginate(page: params[:page], per_page: USERS_PER_PAGE).order(:email)
  end

  def new
    @user = User.new
  end

  def reset_password
    @user = User.find(params[:id])
    @pass_form = ResetPasswordForm.new(@user)
  end

  def reset_password_submit
    @user = User.find(params[:id])
    @pass_form = ResetPasswordForm.new(@user)
    if @pass_form.submit(pass_form_params)
      redirect_to user_path, flash: {success: t(:password_changed) }
    else
      render action: :reset_password
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update!(user_edit_params)
      redirect_to user_path(@user), flash: {success: t(:user_updated)}
    else
      flash.now[:error] = t :could_not_update_user
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

  def user_edit_params
    params.require(:user).permit(:email, :first_name, :last_name, :role,
                                 :nickname, :incl_in_thesis, :incl_in_rankings,
                                 :use_full_name)
  end

  def pass_form_params
    params.require(:reset_password_form).permit(:password,
                                                 :password_confirmation)
  end
end
