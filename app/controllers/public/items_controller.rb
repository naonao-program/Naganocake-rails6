class Public::ItemsController < ApplicationController
  def index
    @items = Public::Item.all
  end
end