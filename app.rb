require 'sinatra'
require 'mechanize'
require 'thin'
require './lib/scarper.rb'
require './lib/locator.rb'

enable :sessions

get '/' do  
  erb :index
end


post '/result_page' do
  locator = Locator.new
  city = locator.location['city']
  session['ip_address'] = city
  keyword = params[:keyword]
  location = params[:location]
  if location == nil
    scraper = Scraper.new(keyword,city)
  else
    scraper = Scraper.new(keyword,location)
  end

  results = scraper.return_job_array
  erb :result_page, :locals => {:results => results}

end  

