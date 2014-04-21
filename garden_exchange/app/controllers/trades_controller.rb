class TradesController < ApplicationController

  def index
  end

  def new
    puts params.inspect
    @item = Item.find(params[:item_id])
    @trade = @item.trades.new
  end

  def create
    puts params.inspect
    @item = Item.find_by(params[:trade][:item_id])
    # @trade = @item.trades.new
    @trade = @item.trades.create(trade_params)
    if @trade.save
      flash[:success] = 'Request sent!'
      redirect_to root_url
    else
      redirect_to root_url
    end
  end


  private

  def trade_params
    params.require(:trade).permit(:name, :comment, :trade_email, :phone_num, :item_id)
  end

end