class OrdersController < ApplicationController
  def show
    @cart = current_cart
    if @cart.cart_items.empty?
      redirect_to products_path, alert: "Votre panier est vide."
      return
    end
  end

  def create
    cart = current_cart

    if cart.cart_items.empty?
      redirect_to products_path, alert: "Votre panier est vide."
      return
    end

    Order.from_cart!(cart: cart, user: current_user)
    reset_current_cart!
    redirect_to products_path, notice: "Votre commande a bien ete enregistree."
  end
end
