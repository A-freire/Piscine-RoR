class UsersController < ApplicationController
  before_action :redirect_signed_in_user, only: %i[new create]
  before_action :set_user, only: %i[show edit update]
  before_action only: %i[show edit update] do
    require_profile_owner(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_user_params)

    if @user.save
      session[:user_id] = @user.id
      cookies.delete(:visitor_name)
      reset_current_user!
      redirect_to root_path, notice: "Welcome #{@user.name}! Your account has been created."
    else
      render_form_errors(@user, :new)
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(update_user_params)
      redirect_to user_path(@user), notice: "Your profile has been updated."
    else
      render_form_errors(@user, :edit)
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def create_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def update_user_params
    params.require(:user).permit(:name, :email)
  end

  def redirect_signed_in_user
    redirect_to root_path, notice: "You are already logged in." if signed_in?
  end
end
