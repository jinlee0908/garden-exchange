class TradesController < ApplicationController
  respond_to :html, :json

  def new
    @item = Item.find_by(id: params[:item_id])
    @trade = @item.trades.new
    respond_with(@trade)
  end

  def create
    @item = Item.find_by(id: params[:trade][:item_id])
    @trade = @item.trades.create(trade_params)
    # binding.pry
    if @trade.save
      @trade.fire_events(:request_made)
      @item.fire_events(:offer_made)
      # flash[:success] = 'Request sent!'
      redirect_to @trade, alert:'Request sent!'
      unless @item.email.empty?
        TradeMailer.request_email(@item, @trade).deliver
        redirect_to list_url
      else
        #send test
      end
    else
      # render 'new'
      # binding.pry
      flash.now[:notice] = "Request can not be sent, please enter information."
      render 'new'
      # redirect_to "new?item_id=#{params[:trade][:item_id]}"
    end
  end


  private

  def trade_params
    params.require(:trade).permit(:name, :comment, :trade_email, :phone_num, :item_id)
  end


end