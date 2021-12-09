class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy] 
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @item = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    return redirect_to root_path if @item.user_id != current_user.id || @item.order.present?
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else 
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else 
      render :show
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :image, :explanation, :price, :category_id, :status_id, :postage_id, :prefecture_id, :shipping_day_id).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end


end