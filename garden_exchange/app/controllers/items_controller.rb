class ItemsController < ApplicationController
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = "Your item is on the exchange!"
      unless @item.email.empty?
        ItemMailer.item_confirmation_email(@item).deliver
      else
        # send a text
      end
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      #success
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def destroy
    # /items/id item_path(item)
    # route that user get to from email confirmation to
  end

  def index
    @items = Item.all
    @hash = Gmaps4rails.build_markers(@items) do |item, marker|
      marker.lat item.latitude
      marker.lng item.longitude
      # marker.inforwindow item.name
    end
  end

  def search_list
    @items = Item.all
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :location, :email, :phone, :category_id)
  end
end
