class ItemsController < ApplicationController
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.slug = SecureRandom.urlsafe_base64
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
    @item = Item.find_by_slug(params[:id])
  end

  def edit
    @item = Item.find_by_slug(params[:id])
    if @item.state == 'inactive' || 'complete'
      flash[:error] = "This item is no longer available."
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def update
    @item = Item.find_by_slug(params[:id])
    if @item.update_attributes(item_params)
      flash[:success] = "You updated your item."
      # success
      redirect_to root_url
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
    @item = Item.find_by_slug(params[:id])
    if @item.state == 'inactive'
      flash[:success] = "This item was already removed."
      redirect_to root_url
    else
      @item.fire_state_event(:cancel)
      @item.image.destroy # remove image from s3
      @item.image.clear # queues attachment to be deleted
      flash[:success] = "Your item was removed from the exchange."
      redirect_to root_url
    end
  end


  private

  def item_params
    params.require(:item).permit(:name, :description, :location, :email, :phone, :category_id, :image, :slug)
  end



  
end
