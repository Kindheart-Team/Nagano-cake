class Public::OrdersController < ApplicationController

#参考サイト「https://qiita.com/saru1439s7/items/17e1cb2a009fc243bca0」動作チェック完了後、コメント消去

  def new
    @order = Order.new
    @addresses = current_customer.addresses.all
  end

  def check
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if params[:order][:address_option] == "0"
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_option] == "1"
      ship = Address.find(params[:order][:customer_id])
      @order.post_code = ship.post_code
      @order.address = ship.address
      @order.name = ship.name
    elsif params[:order][:address_option] = "2"
      @order.post_code = params[:order][:post_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    else
      render :new
    end
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save
      current_customer.cart_items.each do |cart_item| #カート内商品を1つずつ取り出しループ
      @ordered_item = OrderedItem.new #初期化宣言
      @ordered_item.order_id =  @order.id #order注文idを紐付けておく
      @ordered_item.item_id = cart_item.item_id #カート内商品idを注文商品idに代入
      @ordered_item.amount = cart_item.amount #カート内商品の個数を注文商品の個数に代入
      @ordered_item.price = (cart_item.item.price*1.10).floor #消費税込みに計算して代入
      @ordered_item.save
      end
      current_customer.cart_items.destroy_all
      redirect_to complete_path
    else
      render :check
    end
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @ordered_items = @order.ordered_items
  end


  private

  def order_params
    params.require(:order).permit(:customer_id, :post_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

end
