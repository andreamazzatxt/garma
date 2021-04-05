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
    @brand = Brand.find(@brand_id)
  end

  def type
    @brand = Brand.find(params[:id])
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

  def type_search
    brand_id = params["id"]
    barcode = params["barcode"]
    product = Product.find_by(brand: brand_id, article_number: barcode)
    if product.nil?
      flash[:alert] = "Article not found"
      redirect_to type_brand_path(brand_id)
    else
      redirect_to product_path(product)
    end
  end

 #API ACTIONS
  def api_brands
    # /brands/api_brands
    brands = Brand.all
    render json: { brands: brands}
  end

  def api_by_name
    #/brands/api_by_name?query=
    if params[:query].present?
      brands = Brand.search_by_brand_name(params[:query])
    else
      brands = Brand.all
    end
    render json: {brands: brands}
  end
end

