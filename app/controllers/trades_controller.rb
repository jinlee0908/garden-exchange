class TradesController < ApplicationController
  respond_to :html, :json

  def new
    # @item = Item.find_by_slug(params[:item_id])
    @item = Item.find_by(id: params[:item_id])
    @trade = @item.trades.new
    respond_with(@trade)
  end

  def create
    # @item = Item.find_by_slug(params[:trade][:item_id])
    @item = Item.find_by(id: params[:trade][:item_id])
    @trade = @item.trades.create(trade_params)
    if @trade.save
      @trade.fire_events(:request_made)
      @item.fire_events(:offer_made)
      flash[:success] = 'Request sent!'
      unless @item.email.empty?
        TradeMailer.request_email(@item, @trade).deliver
      else
        #send test
      end
      redirect_to root_url
    else
      flash.now[:notice] = "Request can not be sent, please enter missing information."
      render 'new'
    end
  end

  def complete
    @trade = Trade.find_by(id: params[:id])
    # @item = Item.find_by_slug(@trade.item_id)
    # @item = Item.find(@trade.item)
    @item = Item.find_by_slug(@trade.item.slug)
    @trade.fire_events(:completed)
    @item.fire_events(:completed)
    flash[:success] = 'Successful Exchange!'
    redirect_to root_url
  end

  def available
    @trade = Trade.find_by(id: params[:id])
    @item = Item.find(@trade.item_id)
      @trade.fire_events(:cancel)
      @item.fire_events(:reject)
    flash[:success] = 'Your item is available again!'
    redirect_to root_url
  end


  private

  def trade_params
    params.require(:trade).permit(:name, :comment, :trade_email, :phone_num, :item_id)
  end


end