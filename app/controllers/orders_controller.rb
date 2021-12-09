class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]

  def index
    @order_delivery = OrderDelivery.new
      if @item.user_id == current_user.id || @item.order!= nil
        return redirect_to root_path
      end
  end
  
  def create
    @order_delivery = OrderDelivery.new(order_params)
    if @order_delivery.valid?
      pay_item
    @order_delivery.save
    redirect_to root_path
    else
      render :index
      
    end
  end

  private

  def order_params
    params.require(:order_delivery).permit(:postal_code, :prefecture_id, :city, :house_number, :build_number, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end
   
  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,  
      card: order_params[:token],    
      currency: 'jpy'             
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end

