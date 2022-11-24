class Public::HomesController < ApplicationController
  def top
    @items = Item.all.order('id DESC').limit(4)
    # ASCだと古い順でDESCで新着順
  end

  def about
  end

   private

  def item_params
    params.require(:item).permit(:name, :description, :price, :is_active, :genre_id, :image)
  end
end
