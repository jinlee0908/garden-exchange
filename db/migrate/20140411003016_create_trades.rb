class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.integer :item_available_id
      t.string :name
      t.string :comment
      t.string :email
      t.string :phone_num

      t.timestamps
    end
  end
end
