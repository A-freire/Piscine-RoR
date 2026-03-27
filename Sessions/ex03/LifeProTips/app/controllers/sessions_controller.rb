class SessionsController < ApplicationController
  def new
    redirect_to root_path, notice: "You are already logged in." if signed_in?
  end

  def create
    user = authenticate_user

    if user
      session[:user_id] = user.id
      cookies.delete(:visitor_name)
      reset_current_user!
      redirect_to root_path, notice: "Welcome back #{user.name}!"
    else
      @login = params[:login].to_s.strip
      flash.now[:alert] = "Invalid login or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    reset_current_user!
    redirect_to root_path, notice: "You have been logged out."
  end

  private

  def authenticate_user
    login = params[:login].to_s.strip
    password = params[:password].to_s
    user = User.find_by("lower(name) = :value OR lower(email) = :value", value: login.downcase)
    return unless user&.authenticate(password)

    user
  end
end
