class ChangeItemStatusToState < ActiveRecord::Migration
  def self.up
    rename_column :items, :trade_status, :state
  end

  def self.down
    rename_column :items, :state, :trade_status
  end
end
