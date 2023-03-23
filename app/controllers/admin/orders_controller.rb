class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @order_posts = @order.order_posts
  end

  def update
    @order = Order.find(params[:id])
    item_orders = @order.order_posts
    if @order.update(update_status_params)
      if params[:order][:status] == "1"
        item_orders.each do |item_order|
          item_order.making_status = "1"
          item_order.save
        end
      end
      flash[:notice] = '更新されました。'
      redirect_to admin_orders_path
    else
      @order_details = @order.status
      render :show
    end
  end

  private
  def order_params
    params.require(:order).permit(:customer_id,:postal_code,:address,
                                  :name,:shipping_cost,:total_payment)
  end

  def update_status_params
    params.require(:order).permit(:status)
  end

  def order_status_params
    params.require(:order).permit(:making_status).merge(making_status: params[:order][:making_status].to_i)
  end

end
