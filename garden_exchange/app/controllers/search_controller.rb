class SearchController < ApplicationController

  def index
    if params[:search].present?
      selected_miles = miles(params[:search][:miles])
      addresses = Item.near(params[:search][:location], selected_miles)
      @items = addresses.search(params[:item][:category_id]) && addresses.where(state: :active)
    else
      @items = Item.where(state: :active)
    end
    @locations = Search.markers(@items)
  end

  def search_list
    if params[:search].present?
      selected_miles = miles(params[:search][:miles])
      addresses = Item.near(params[:search][:location], selected_miles)
      @items = addresses.search(params[:item][:category_id]) && addresses.where(state: :active)
    else
      @items = Item.where(state: :active)
    end
  end


  private

  def miles(miles)
    if params[:search][:miles].empty?
      99
    else
      params[:search][:miles]
    end
  end

  def search_params
    params.require(:search).permit(:latitidue, :longitude, :miles)
  end

end
