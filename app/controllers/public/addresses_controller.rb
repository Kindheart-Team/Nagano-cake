class Public::AddressesController < ApplicationController

  def index
    @addresses = Address.all
    @address = Address.new
    @customer = current_customer
  end

  def edit
    @address = Address.find(params[:id])
    @customer = current_customer
  end

  def create
    @address = Address.new
    if @address.save
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end

  private

  #以下要修正！！permit以降を修正すること！！
  def address_params
    params.require(:address).permit(:post_code, :address, :name)
  end

end
