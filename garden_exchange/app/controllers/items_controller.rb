class ItemsController < ApplicationController
  
  def new
    @item = Item.new
  end

  def create
    @curent_location = latlong(params[:latitude], params[:longitude])
    binding.pry
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
    # add something to check state here
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      # success
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
    @item = Item.find(params[:id])
    @item.fire_state_event(:cancel)
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

  
end
