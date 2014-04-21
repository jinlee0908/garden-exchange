class TradeController < ApplicationController

  # def new
  #   @trade = Trade.new
  # end


  def create
    @trade = Item.find(params[:id]).trades.build(trade_params)
    if @trade.save
      flash[:success] = 'Trade created!'
    else
      render 'trade'
  end


  private

  def item_params
    params.require(:trade).permit(:name, :comment, :email, :phone_num,)
  end

end