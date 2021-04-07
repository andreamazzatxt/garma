class GarderobeItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!, only:[:api_delete_product, :api_save_product]
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

  def api_delete_product
    product = Product.find_by(id: params[:id])
    if current_user
    item = GarderobeItem.find_by(product: product, user: current_user)
      if item
        render json: { status: 'deleted',  item: item, product: product } if item.destroy
      else
        render json: { error: 'Product not in garderobe of current user'}, status: 401
      end
    else
      render json: {error: 'User not logged in'}, status: 401
    end
  end
  
  def api_save_product
    product = Product.find_by(id: params[:id].to_i)
    if current_user
      exist = GarderobeItem.find_by(product: product, user: current_user)
      if exist
        render json: { error: 'Product already saved' }, status: 401
      else
        item = GarderobeItem.new(product: product, user: current_user)
        render json: { saved_item: item, product: product } if item.save
      end
    else
      render json: { error: 'User not logged in'}, status: 401
    end
  end
end
