class BrandsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:scan, :search]
  skip_before_action :verify_authenticity_token, only: [:search]
  def index
  @brands = Brand.all
  end

  def scan
    @brand_id = params[:id]
  end

  def search
    brand_id = params["id"]
    barcode = params["barcode"]["text"]
    product = Product.find_by(brand: brand_id, article_number: barcode)
    p product
    if product.nil?
      p "😩 ARTICLE NOT FOUND"
      render json: { url: nil }
    else
      p "✅ ARTICLE FOUND"
      render json: { url: "/products/#{product.id}" }
    end
  end
end
