class Hotspot
  include Mongoid::Document
  include Mongoid::Timestamps
  include Geokit::Geocoders
  
  field :name
  field :geo, :type => Array, :default => [ 0, 0 ]
  
  index [[ :geo, Mongo::GEO2D ]], :min => -200, :max => 200
  
end
