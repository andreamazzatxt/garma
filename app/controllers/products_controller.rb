class ProductsController < ApplicationController
  before_action :find_product, only: [:show]
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @saved = saved?
  end

  def index
    garderobe = GarderobeItem.where(user: current_user)
    @products = garderobe.map { |item| item.product }
    total_rating = @products.reduce(0) { |sum, product| sum + product.total_rating }
    total_rating = @products.size.zero? ? 0 : (total_rating / @products.size).round
    @karma = 'bad'
    @karma = 'medium' if total_rating == 3
    @karma = 'good' if total_rating == 4 || total_rating == 5
    @karma = 'neutral' if total_rating.zero?
  end

  private

  # Params and find PRODUCT

  def product_params
    params.require(:product).permit(:name, :brand_id, :photo_url, :category, :article_number, :department)
  end

  def find_product
    @product = Product.find(params[:id])
  end

  def saved?
    return false if current_user.nil?

    product = GarderobeItem.where(user: current_user, product: @product)
    return product.size.zero? ? false : true
  end
end
