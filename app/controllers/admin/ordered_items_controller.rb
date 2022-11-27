class Admin::OrderedItemsController < ApplicationController

  def update
    @ordered_item = OrderedItem.find(params[:id])
    @order = @ordered_item.order
    @ordered_items = @order.ordered_items

    is_updated = true
    if @ordered_item.update(ordered_item_params)
      @order.update(status: 2) if @ordered_item.making_status == "making"
      @ordered_items.each do |ordered_item|
        if ordered_item.making_status != "completed"
          is_updated = false
        end
      end
      @order.update(status: 3) if is_updated
    end
    redirect_to admin_order_path(@ordered_item.order.id)
  end

  private

  def ordered_item_params
    params.require(:ordered_item).permit(:order_id, :item_id, :amount, :price, :making_status)
  end

end