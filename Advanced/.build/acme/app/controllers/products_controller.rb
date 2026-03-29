class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  before_action :authorize_catalog_write!, only: %i[new create edit update destroy]

  def index
    @products = Product.ordered
    @cart = current_cart
  end

  def show
    authorize! :read, @product
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product, notice: "Le produit a bien ete cree."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: "Le produit a bien ete mis a jour."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy!
    redirect_to products_path, notice: "Le produit a bien ete supprime."
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def authorize_catalog_write!
    target = @product || Product
    action =
      if action_name.in?(%w[new create])
        :create
      elsif action_name.in?(%w[edit update])
        :update
      else
        :destroy
      end

    authorize! action, target
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :brand_id, :pict)
  end
end
