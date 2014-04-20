class SearchController < ApplicationController

  def index
      if params[:search].present?
        found_address=latlong(params[:search][:latitude], params[:search][:longitude])
        selected_miles = miles(params[:search][:miles])
        addresses = Item.near(found_address, selected_miles)
        @items = addresses.search(params[:item][:category_id]) 
      else
        @items = Item.all
      end
          puts params.inspect
      @locations = Search.markers(@items)

    end

  def search_list
    @items = Item.all
  end


  private

  def latlong(latitude, longitude)
    search_address = Geocoder.search([latitude, longitude])
    unless search_address[0].nil?
      search_address[0].data["formatted_address"]
    else
      #ToDo - come up an alternate or default if something query...
    end  
  end

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
