class GarderobeItemsController < ApplicationController
  def create
    @product = Product.find(params[:product_id].to_i)
    item = GarderobeItem.new(product: @product, user: current_user)
    if item.save
      redirect_to product_path(@product, anchor: 'save-container')
    end
  end

  def destroy
    @product = Product.find(params[:id].to_i)
    item = GarderobeItem.find_by(product: @product, user: current_user)
    if item.destroy
      redirect_to product_path(@product, anchor: 'save-container')
    end
  end
end
