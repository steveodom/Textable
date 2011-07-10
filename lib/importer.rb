require 'csv'

class Importer
  
  def self.wifi
    CSV.foreach('./vendor/data/BusinesseswithfreeWiFi.csv', :headers => :first_row) {|row|
      begin
        hotspot = Hotspot.create(:name => Cleaner.make_ascii(row[2]), :geo => [row[1].to_f, row[0].to_f])
      rescue
        puts row[2]
      end
    }
  end
  
  def self.walgreens
    CSV.foreach('./vendor/data/walgreens.csv', :headers => :first_row) {|row|
        begin
          address = row[3] + " " + row[2]
          hotspot = Walgreen.create(:name => Cleaner.make_ascii(row[0]), :address => row[3], :geo => [row[4].to_f, row[5].to_f])
        rescue
          puts row[1]
        end
    }
  end
  
  def self.lib
    CSV.foreach('./vendor/data/PublicLibrariesUSA.csv', :headers => :first_row) {|row|
      begin
        hotspot = FreeBook.create(:name => Cleaner.make_ascii(row[2]), :address => row[3], :geo => [row[1].to_f, row[0].to_f])
      rescue
        puts row[2]
      end
    }
  end
  
  def self.airports
    CSV.foreach('./vendor/data/airport_locations.csv', :headers => :first_row) {|row|
      begin
        next if row[6] != "US"
        airport = Airport.create(:name => Cleaner.make_ascii(row[3]), :code => row[0], :geo => [row[1].to_f, row[2].to_f])
      rescue
        puts row[2]
      end
    }
    
  end
end