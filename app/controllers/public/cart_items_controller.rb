class Public::CartItemsController < ApplicationController
  def index
    @carts = current_customer.item
  end

  def create
    @cart = Cart.new(cart_params)
    if @cart.save
      redirect_to cart_items_path
    else
      render 'public/items/show'
    end
  end

  private
  def cart_params
    params.require(:cart).permit(:amount)
  end
end
