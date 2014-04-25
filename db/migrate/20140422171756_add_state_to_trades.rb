class AddStateToTrades < ActiveRecord::Migration
  def change
    add_column :trades, :state, :string
  end
end
