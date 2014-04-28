class AddIndexToItemsSlug < ActiveRecord::Migration
  def change
    add_index :items, :slug
  end
end
