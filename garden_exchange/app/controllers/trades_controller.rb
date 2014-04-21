class TradesController < ApplicationController

  # def new
  #   @trade = Trade.new
  # end

  def index
  end

  def new
    @item = Item.find(params[:item_id])
    @trade = Trade.new
  end

  def create
    puts params.inspect
    @trade = Item.find(params[:item_id]).trades.build(trade_params)
    if @trade.save
      flash[:success] = 'Trade created!'
    else
      render 'trade'
    end
  end


  private

  def trade_params
    params.require(:trade).permit(:name, :comment, :trade_email, :phone_num,)
  end

end