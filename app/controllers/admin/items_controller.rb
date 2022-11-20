class ItemsController < ApplicationController
  def new
  end

  def index
    @items = Item.all
    @item = Item.new
  end

  def show
  end

  def edit
  end
end
