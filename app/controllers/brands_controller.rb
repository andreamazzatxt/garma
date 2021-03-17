class BrandsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:search]
  def index
  @brands = Brand.all
  end

  def scan
    @brand_id = params[:id]
  end

  def search
    @disable_nav
    brand_id = params["id"]
    barcode = params["barcode"]["text"]
    product = Product.find_by(brand: brand_id, article_number: barcode)
    if product.nil?
      render json: { url: nil }
    else
      render json: { url: "/products/#{product.id}" }
    end
  end
end
