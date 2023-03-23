class Admin::OrderPostsController < ApplicationController
  def update
    order_post = OrderPost.find(params[:id])
    order_status = order_post.order
    if order_post.update(order_post_params)
      if params[:order_post][:making_status] == "2"
        order_status.status = "2"
        order_status.save
      elsif order_status.order_posts.count == order_status.order_posts.where(making_status: "3").count
        order_status.status = "3"
        order_status.save
      end
      redirect_to admin_order_path(order_post.order_id)
    end
  end

  private
  def order_post_params
    params.require(:order_post).permit(:making_status)
  end
end
