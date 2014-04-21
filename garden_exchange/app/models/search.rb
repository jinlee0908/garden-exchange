class Search
  include ActiveModel::Model


  def self.markers(items)
   Gmaps4rails.build_markers(items) do |item, marker|
      marker.lat item.latitude
      marker.lng item.longitude
      marker.title item.category.category
      marker.infowindow "<b><a href=trades/new?item_id=#{item.id}>#{item.name}</a></b>"
    end
  end

  private

end