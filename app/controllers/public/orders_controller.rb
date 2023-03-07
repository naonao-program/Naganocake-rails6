class Public::OrdersController < ApplicationController
  before_action :ensure_cart_items, only: [:new]
  before_action :cart_item_check, only: [:new, :confirm, :create]
  def new
    @order = Order.new
    address = Address.all
    @addresses = current_customer.addresses
  end

  def comfirm
    @order = Order.new(order_params)
    @cart_items = CartItem.all
    @order.shipping_cost = 800
    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_option] == "1"
      shipment_address = Address.find(params[:order][:registered_address])
      @order.postal_code = shipment_address.postal_code
      @order.address = shipment_address.address
      @order.name = shipment_address.name
    elsif params[:order][:address_option] == "2"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      current_customer.cart_items.each do | cart_item |
        order_post = OrderPost.new
        order_post.item_id = cart_item.item_id
        order_post.amount = cart_item.amount
        order_post.making_status = "no_running"
        order_post.price = cart_item.item.price
        order_post.order_id = @order.id
        order_post.save
      end
    end
    cart_item = current_customer.cart_items
    cart_item.destroy_all
    redirect_to complete_orders_path
  end

  def complete
  end

  private
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, 
                                  :customer_id, :shipping_cost, :total_payment, :status)
  end

  def ensure_cart_items
    @cart_items = current_customer.cart_items.includes(:item)
    redirect_to items_path unless @cart_items.first
  end

  def cart_item_check
    cart_item = current_customer.cart_items
    unless cart_item.exists?
      redirect_to items_path
    end
  end

end