class CartItemsController < ApplicationController
  before_action :set_cart_item, only: %i[increment decrement destroy]

  def create
    product = Product.find(params[:product_id])
    current_cart.add_product(product)
    redirect_back fallback_location: products_path, notice: "#{product.name} a ete ajoute au panier."
  end

  def increment
    @cart_item.increment!(:quantity)
    redirect_back fallback_location: cart_path, notice: "La quantite a ete augmentee."
  end

  def decrement
    if @cart_item.quantity <= 1
      @cart_item.destroy!
      message = "L'article a ete retire du panier."
    else
      @cart_item.decrement!(:quantity)
      message = "La quantite a ete diminuee."
    end

    redirect_back fallback_location: cart_path, notice: message
  end

  def destroy
    @cart_item.destroy!
    redirect_back fallback_location: cart_path, notice: "L'article a ete retire du panier."
  end

  private

  def set_cart_item
    @cart_item = current_cart.cart_items.find(params[:id])
  end
end
