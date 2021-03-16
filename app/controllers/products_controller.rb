class ProductsController < ApplicationController
  before_action :find_product, only: [:show]

  def show
  end

  private

  # Params and find PRODUCT

  def product_params
    params.require(:product).permit(:name, :brand_id, :photo_url, :category, :article_number, :department)
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
