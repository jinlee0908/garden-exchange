class ItemsController < ApplicationController
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = "Your item is on the exchange!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    # /items/<id>/edit edit_item_path(item)
    # route that user gets to from email confirmation
    # need to know if user is editing or cancelling
  end

  def destroy
    # /items/id item_path(item)
    # route that user get to from email confirmation to
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :location, :email, :phone, :category_id)
  end
end
