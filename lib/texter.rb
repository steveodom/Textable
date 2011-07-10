class Texter
  
  def initialize(body)
    ary = body.split(" ")
    @action = ary[0].downcase
    zip = ary[1]
    @geo = geo(zip)  if zip
  end
  
  def geo(zip)
    if zip.to_i == 0
      airport = Airport.where(:code => zip.upcase).first
      {:lat => airport.geo[0], :lng => airport.geo[1] }
    else
      geo = Geo.geocode(zip)
      {:lat => geo.lat, :lng => geo.lng}
    end
  end
  
  def response
    case @action
     when "wifi" then build_wifi
     when "library"  then build_libraries
     when "walgreens"  then build_walgreens
     when "ufos" then build_ufos
     when "walmart" then build_walmart
     when "atm"  then build_atm
     when "help" then build_help
     else "Sorry I didn't understand. Try: wifi 78702 | lib 78702 | ufos 78702"
     end
  end
  
  def build_help
    "A keyword (wifi, library, walgreens, walmart, ufos, or atms) followed by a location (POSTAL CODE or Airport Code). Ex: wifi 78702"
  end

  def build_walgreens
    location = Walgreen.near(:geo => [@geo[:lat], @geo[:lng]]).limit(1).first
    location.address
  end

  def build_wifi
     locations = Hotspot.near(:geo => [@geo[:lat], @geo[:lng]]).limit(30) 
     ary = []
     locations.each do |l|
       ary << l.name if !ary.include? l.name
       break if ary.size > 8
     end 
     ary.to_sentence
  end

  def build_libraries
    location = FreeBook.near(:geo => [@geo[:lat], @geo[:lng]]).limit(1).first
    %(#{location.name} #{location.address})
  end

  def build_ufos
    "not implemented"
  end
  
  def build_walmart
    "not implemented"
  end
  
  def build_atm
    "not implemented"
  end

end