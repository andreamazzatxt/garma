class GarderobeItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    @product = Product.find(params[:product_id].to_i)
    item = GarderobeItem.new(product: @product, user: current_user)
    render json: { id: item.id } if item.save
  end

  def destroy
    item = GarderobeItem.find(params[:id])
    if item.user == current_user
      render json: { status: 'deleted' } if item.destroy
    else
      render json: { status: 'rejected' }
    end
  end
end
