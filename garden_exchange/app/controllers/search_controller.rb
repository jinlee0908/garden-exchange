class SearchController < ApplicationController

  def index
    if params[:search].present? && params[:item][:category_id] == '1'
      selected_miles = miles(params[:search][:miles])
      addresses = Item.near(params[:search][:location], selected_miles)
      @items = addresses.where(:state => :active)
    elsif params[:search].present? && params[:item][:category_id] != '1'
      selected_miles = miles(params[:search][:miles])
      category_id = category(params[:item][:category_id])
      addresses = Item.near(params[:search][:location], selected_miles)
      @items = addresses.where({:state => :active, :category_id => category_id.to_i})
    else
      @items = Item.where(state: :active)
    end
    @locations = Search.markers(@items)
  end


  def search_list
    if params[:search].present?
      selected_miles = miles(params[:search][:miles])
      addresses = Item.near(params[:search][:location], selected_miles, :order => :distance)
      selected_category = addresses.search(params[:item][:category_id])
      @items = selected_category.where(state: :active).paginate(:per_page => 10, :page => params[:page])
    else
      @items = Item.where(state: :active).paginate(:per_page => 10, :page => params[:page])
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


  def search_params
    params.require(:search).permit(:latitidue, :longitude, :miles)
  end

end
