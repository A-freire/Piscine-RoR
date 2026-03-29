class BrandsController < ApplicationController
  before_action :set_brand, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  before_action :authorize_catalog_write!, only: %i[new create edit update destroy]

  def index
    @brands = Brand.includes(:products).order(:name)
  end

  def show
    authorize! :read, @brand
    @products = @brand.products.ordered
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)

    if @brand.save
      redirect_to @brand, notice: "La marque a bien ete creee."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @brand.update(brand_params)
      redirect_to @brand, notice: "La marque a bien ete mise a jour."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @brand.destroy!
    redirect_to brands_path, notice: "La marque a bien ete supprimee."
  end

  private

  def set_brand
    @brand = Brand.find(params[:id])
  end

  def authorize_catalog_write!
    target = @brand || Brand
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

  def brand_params
    params.require(:brand).permit(:name, :avatar)
  end
end
