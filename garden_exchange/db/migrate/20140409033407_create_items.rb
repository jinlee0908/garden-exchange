class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.string :location
      t.string :email
      t.string :phone
      t.string :trade_status
      t.integer :image_id
      t.integer :category_id

      t.timestamps
    end
  end
end
