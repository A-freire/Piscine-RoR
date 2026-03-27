class ApplicationController < ActionController::Base
  ANIMAL_NAMES = %w[
    Lion Tiger Bear Leopard Elephant Giraffe Zebra Kangaroo
  ].freeze

  helper_method :current_user, :logged_in_user, :signed_in?, :can_edit_post?, :can_destroy_post?

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  rescue_from ActionController::ParameterMissing, with: :handle_bad_request

  private

  def current_user
    @current_user ||= find_current_user
  end

  def logged_in_user
    current_user if signed_in?
  end

  def signed_in?
    current_user.is_a?(User)
  end

  def require_account(message = "You need an account to do this")
    return if signed_in?

    redirect_to root_path, notice: message
  end

  def require_profile_owner(user)
    return if signed_in? && logged_in_user == user

    redirect_to root_path, alert: "You can only access your own profile."
  end

  def can_edit_post?(post)
    return false unless signed_in?
    return true if logged_in_user.admin?
    return true if post.user == logged_in_user

    logged_in_user.can_edit_other_posts? && post.user != logged_in_user
  end

  def can_destroy_post?(post)
    signed_in? && (logged_in_user.admin? || post.user == logged_in_user)
  end

  def render_form_errors(record, template)
    flash.now[:alert] = record.errors.full_messages.to_sentence
    render template, status: :unprocessable_entity
  end

  def reset_current_user!
    @current_user = nil
  end

  def find_current_user
    user = User.find_by(id: session[:user_id])
    return user if user

    session.delete(:user_id)
    GuestUser.new(visitor_name)
  end

  def visitor_name
    name = cookies[:visitor_name]
    return name if name.present?

    name = ANIMAL_NAMES.sample
    cookies[:visitor_name] = {
      value: name,
      expires: 1.minute.from_now,
      httponly: true
    }
    name
  end

  def handle_not_found
    redirect_to root_path, alert: "The requested resource could not be found."
  end

  def handle_bad_request
    redirect_to root_path, alert: "The submitted form was incomplete."
  end
end
