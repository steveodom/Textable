class FreeBook
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  field :address
  field :geo, :type => Array, :default => [ 0, 0 ]
  
  index [[ :geo, Mongo::GEO2D ]], :min => -200, :max => 200
  
end
