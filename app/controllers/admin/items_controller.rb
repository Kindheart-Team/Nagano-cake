class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
    @genres = Genre.all.map { |genre| [ genre.name] }

  end

  def create
    @genres = Genre.all
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_items_path
  end

  def index
    @items = Item.all
    @item = Item.new
  end

  def show
  end

  def edit
  end

  def item_params
    params.require(:item).permit(:name, :description, :price, :is_active, :genre_id)
  end

end
