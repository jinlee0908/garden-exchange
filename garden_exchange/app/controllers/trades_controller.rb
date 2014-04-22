class TradesController < ApplicationController

  def new
    @item = Item.find_by(id: params[:item_id])
    @trade = @item.trades.new
  end

  def create
    @item = Item.find_by(id: params[:trade][:item_id])
    @trade = @item.trades.create(trade_params)
    if @trade.save!
      @trade.fire_events(:request_made)
      @item.fire_events(:offer_made)
      flash[:success] = 'Request sent!'
      unless @item.email.empty?
        TradeMailer.request_email(@item, @trade).deliver
        redirect_to list_url
      else
        #send test
      end
    else
      redirect_to root_url
    end
  end


  private

  def trade_params
    params.require(:trade).permit(:name, :comment, :trade_email, :phone_num, :item_id)
  end


end