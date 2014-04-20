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
      redirect_to @item
    else
      render 'edit'
    end
  end

  def upload
     uploaded_io = params[:items][:image]
     File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
       file.write(uploaded_io.read)
     end
  end

  def destroy
    # /items/id item_path(item)
    # route that user get to from email confirmation to
  end

 def index
    if params[:search]
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

  def item_params
    params.require(:item).permit(:name, :description, :location, :email, :phone, :category_id, :image)
  end

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

  
end
