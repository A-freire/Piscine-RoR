class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[edit update destroy]

  def index
    @users = User.order(:name)
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "User updated successfully."
    else
      render_form_errors(@user, :edit)
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "User deleted successfully."
    else
      redirect_to admin_users_path, alert: @user.errors.full_messages.to_sentence
    end
  rescue ActiveRecord::InvalidForeignKey
    redirect_to admin_users_path,
                alert: "This user is still referenced elsewhere and cannot be deleted."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
