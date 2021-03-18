class BrandsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:search]
  def index
      if params[:query].present?
      @brands = Brand.search_by_brand_name(params[:query])
    else
      @brands = Brand.all
    end
  end

  def scan
    @disable_nav = true
    @brand_id = params[:id]
  end

  def search
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

