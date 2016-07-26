require 'httparty'

class Locator

  def initalize(ip_address)
    @ip_address = ip_address
  end

  def find_ip 
    ip_lookup = HTTParty.get("http://ip-api.com/json/#{@ip_address}")
    location = {"country" => find_country(ip_lookup), 
      "region" => find_region(ip_lookup), 
      "city" => find_city(ip_lookup) }
    puts location
  end

  def find_country(ip_lookup)
    ip_lookup['country']
  end

  def find_city(ip_lookup)
    ip_lookup['city']
  end

  def find_region(ip_lookup)
    ip_lookup['region']
  end

end

l = Locator.new
l.find_ip