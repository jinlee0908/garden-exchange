class AddGmapsToItems < ActiveRecord::Migration
  def change
    add_column :items, :gmaps, :boolean
  end
end
