require 'sinatra'
require 'mongoid'
require 'builder'
# require 'ruby-debug'

Dir['./lib/*.rb'].each{ |f| require f }

# Set up the Mongo Connection
CONFIG = YAML.load_file('./config/config.yml')
mongo = CONFIG["mongo"][settings.environment.to_s]
Mongoid.database = Mongo::Connection.from_uri(mongo["uri"]).db(mongo["database"])
Mongoid.autocreate_indexes = true

get '/receive' do
  begin
    builder do |xml|
        xml.instruct!
        xml.Response do 
          xml.Sms(Texter.new(params["Body"]).response)
        end
    end 
  rescue
    render_sorry
  end
end

# this is to test locally.
get '/receive/:Body' do
  begin
    builder do |xml|
        xml.instruct!
        xml.Response do 
          xml.Sms(Texter.new(params["Body"]).response)
        end
    end 
  rescue
    render_sorry
  end
end

# import datasets into Mongo so we can search them.
get '/import/:klass' do
    Importer.send(params["klass"])
end

def render_sorry
  builder do |xml|
      xml.instruct!
      xml.Response do 
        xml.Sms("Sorry. I didn't understand that command.")
      end
  end
end
