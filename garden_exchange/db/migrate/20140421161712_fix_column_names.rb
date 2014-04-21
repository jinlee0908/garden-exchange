class FixColumnNames < ActiveRecord::Migration
  def change
    rename_column :trades, :item_available_id, :item_id
    rename_column :trades, :email, :trade_email
  end
end
