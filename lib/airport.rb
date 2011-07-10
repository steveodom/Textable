class Airport
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  field :code
  field :geo, :type => Array, :default => [ 0, 0 ]
  
  index [[ :geo, Mongo::GEO2D ]], :min => -200, :max => 200
  
end
