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
    if @order.update(update_status_params)
      if @order.status == "0"
        @order.order_details.each do |order_detail|
          order_detail.making_status = "1"
          order_detail.save!
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

end
