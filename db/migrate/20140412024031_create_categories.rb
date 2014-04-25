class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :category
      t.integer :image_id

      t.timestamps
    end
  end
end
