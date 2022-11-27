class Admin::OrderedItemsController < ApplicationController

  def update
    @order = Order.find(params[:id])
    @ordered_item = OrderedItem.find(params[:id])
    @ordered_items = @order.ordered_items.all

    is_updated = true
    if @ordered_item.update(ordered_item_params)
      @order.update(status: 2) if @ordered_item.making_status == "making"
      @ordered_items.each do |ordered_item| #　紐付いている注文商品の製作ステータスを一つ一つeach文で確認していきます。
        if ordered_item.making_status != "completed" # 製作ステータスが「製作完了」ではない場合
          is_updated = false # 上記で定義してあるis_updatedを「false」に変更する。
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