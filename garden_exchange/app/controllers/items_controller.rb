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
    if @item.state == 'inactive'
      flash[:error] = "This item is no longer available."
      redirect_to root_url
    else
      flash[:error] = "This item's state is #{@item.state}"
      render 'edit'
    end
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
    if @item.state == 'inactive'
      flash[:success] = "This item was already removed."
      redirect_to root_url
    else
      @item.fire_state_event(:cancel)
      flash[:success] = "Your item was removed from the exchange."
      redirect_to root_url
    end
  end

  

  private

  def item_params
    params.require(:item).permit(:name, :description, :location, :email, :phone, :category_id, :image)
  end



  
end
