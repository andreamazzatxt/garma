class BrandsController < ApplicationController
  def index
  @brands = Brand.all
  end

  def scan

  end
end
