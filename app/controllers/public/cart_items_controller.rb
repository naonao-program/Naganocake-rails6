class Public::CartItemsController < ApplicationController
  def create
    @cart = Cart.new(cart_params)
  end

  private
  def cart_params
    params.require(:cart).permit(:amount)
  end
end
