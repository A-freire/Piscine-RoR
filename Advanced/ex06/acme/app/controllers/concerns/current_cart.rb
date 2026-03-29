module CurrentCart
  extend ActiveSupport::Concern

  included do
    helper_method :current_cart
  end

  private

  def current_cart
    @current_cart ||= Cart.find_or_create_by!(session_token: cart_session_token)
  end

  def reset_current_cart!
    current_cart.destroy! if current_cart.persisted?
    @current_cart = nil
    cookies.permanent.signed[:cart_session_token] = SecureRandom.uuid
  end

  def cart_session_token
    cookies.permanent.signed[:cart_session_token] ||= SecureRandom.uuid
  end
end
