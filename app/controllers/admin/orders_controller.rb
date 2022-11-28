class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.page(params[:page])
  end

  def show
    @order = Order.find(params[:id])
    @ordered_items = @order.ordered_items
    @total = 0

  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      @ordered_items = @order.ordered_items
      @ordered_items.update_all(making_status: 1) if @order.status == "confilm"
    end
    redirect_to admin_order_path(@order.id)
  end





  private
  def order_params
    params.require(:order).permit(:status)
  end




end