class ItemsController < ApplicationController
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      # code if things are successful
    else
      render 'new'
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :location, :email, :phone)
  end
end
