class Location < ActiveRecord::Base
  geocoded_by :address #this can be a method to pull in... 
  after_validation :geocode, :if => :address_changed?

end
