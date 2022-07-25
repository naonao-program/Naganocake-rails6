class Public::CartItemsController < ApplicationController
  def index
    @carts = current_customer.cart_items
  end

  def create
    @cart = CartItem.new(cart_item_params)
    current_cart_items = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    if current_cart_items.present?
      cart_item = CartItem.find_by(item_id: @cart.item_id, customer_id: current_customer.id)
      cart_item.update!(amount: cart_item.amount + @cart.amount)
      redirect_to cart_items_path
    else
      @cart.customer_id = current_customer.id
      @cart.save!
      redirect_to items_path
    end
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:amount,:item_id, :customer_id)
  end
end
