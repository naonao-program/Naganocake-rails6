class Public::OrdersController < ApplicationController
  before_action :ensure_cart_items, only: [:new]
  def new
    @order = Order.new
    address = Address.all
  end

  def ensure_cart_items
    @cart_items = current_customer.cart_items.includes(:item)
    redirect_to items_path unless @cart_items.first
  end
end
