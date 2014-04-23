class SearchController < ApplicationController

  def index
    selected_miles = miles(params[:search][:miles])
    category_id = category(params[:item][:category_id])
    if params[:search].empty?
      @items = Item.where(state: :active)
    elsif params[:search].present? && params[:item][:category_id] == '1'
      addresses = Item.near(params[:search][:location], selected_miles)
      @items = addresses.where(:state => :active)
    else
      addresses = Item.near(params[:search][:location], selected_miles)
      @items = addresses.where({:state => :active, :category_id => category_id.to_i})
    end
    @locations = Search.markers(@items)
  end


  def search_list
    if params[:search].present?
      selected_miles = miles(params[:search][:miles])
      addresses = Item.near(params[:search][:location], selected_miles)
      selected_category = addresses.search(params[:item][:category_id])
      @items = selected_category.where(state: :active)
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


  def category(category_id)
    params[:item][:category_id]
  end

  def state(state)
    :active
  end

  def search_params
    params.require(:search).permit(:latitidue, :longitude, :miles)
  end

end
