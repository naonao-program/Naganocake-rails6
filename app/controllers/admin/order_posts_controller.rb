class Admin::OrderPostsController < ApplicationController
  def update
    order_post = OrderPost.find(params[:id])
    if order_post.update(order_post_params)
      produce_executed_count = 0
      order_post.order.order_posts.each do |a|
        if a.making_status == 0
          produce_executed_count += 1
        else
          break
        end
      end

      if order_post.making_status == "2"
        order_post.order.status = "3"
      elsif
        produce_executed_count == order_post.order.order_posts.count
        order_post.order.status = "2"
      end
      order_post.order.save!
      flash[:notice] = '更新されました。'
    else
      @order = order_post.order
      @order_post = @order.order_post
      render "orders/show"
    end
    redirect_to admin_order_path(order_post.order_id)
  end

  private
  def order_post_params
    params.require(:order_post).permit(:making_status)
  end
end
