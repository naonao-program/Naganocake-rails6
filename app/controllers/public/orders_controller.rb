class Public::OrdersController < ApplicationController
  before_action :ensure_cart_items, only: [:new]
  def new
    @order = Order.new
    address = Address.all
  end

  def comfirm
    @order = Order.new(order_params)
    @cart_items = CartItem.all
  end

  def create
    @order = Order.new(order_params)
    if @order.save
    end
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