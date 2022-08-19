class Public::OrdersController < ApplicationController
  before_action :ensure_cart_items, only: [:new]
  def new
    @order = Order.new
    address = Address.all
  end

  def comfirm
    @order = Order.new(order_params)
    @cart_items = CartItem.all
    @order.shipping_cost = 800
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    end
  end

  def create
    @order = Order.new(order_params)
    @order.save
    cart_item = current_customer.cart_items
    cart_item.destroy_all
    redirect_to complete_orders_path
  end

  def complete
  end

  private
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method)
  end

  def ensure_cart_items
    @cart_items = current_customer.cart_items.includes(:item)
    redirect_to items_path unless @cart_items.first
  end
end