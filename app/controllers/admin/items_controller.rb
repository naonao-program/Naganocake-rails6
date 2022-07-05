class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item_new = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item)
    else
      render :new
    end
  end

  private
  def item_params
    params.require(:item).permit(:image_id, :name, :introduction, :genre_id,:price, :is_active)
  end
end
