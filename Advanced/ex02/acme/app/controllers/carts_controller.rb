class CartsController < ApplicationController
  def show
    @cart = current_cart
  end

  def destroy
    reset_current_cart!
    redirect_to products_path, notice: "Le panier a ete vide."
  end
end
