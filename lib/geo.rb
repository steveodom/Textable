require 'geokit'

class Geo
  include Geokit::Geocoders
  
  def self.reverse_geocode(ary)
    GoogleGeocoder.reverse_geocode(ary)
  end
  
  def self.geocode(postal)
    MultiGeocoder.geocode(postal)
  end
end
