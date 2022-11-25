class Admin::OrderedItemsController < ApplicationController
  
  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to order_path(@order.id)
  end
  
  
end
