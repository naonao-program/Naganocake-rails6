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
    end
    redirect_to admin_order_path(order_post.order_id)
  end

  private
  def order_post_params
    params.require(:order_post).permit(:making_status)
  end
end
