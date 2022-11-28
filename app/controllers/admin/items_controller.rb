class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
    @genres = Genre.all.map { |genre| [ genre.name, genre.id] }


  end

  def create
    @genres = Genre.all
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_item_path(@item.id)
  end

  def index
    @items = Item.page(params[:page])
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all.map { |genre| [ genre.name, genre.id] }
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to admin_item_path(@item.id)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :is_active, :genre_id, :image)
  end

end
