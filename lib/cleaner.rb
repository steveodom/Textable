class Cleaner
  
  def self.make_ascii(str)
    begin
      Iconv.new('ASCII//IGNORE//TRANSLIT', 'UTF-8').iconv(str)
    rescue
      puts str
    end
  end
  
end