class Admin::OrderedItemsController < ApplicationController

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to order_path(@order.id)
  end

  private

  def ordered_item_params
    params.require(:ordered_item).permit(:order_id, :item_id, :amount, :price, :making_status)
  end

end
