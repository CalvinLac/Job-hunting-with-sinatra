require 'sinatra'
require 'mechanize'
require 'thin'
require './lib/scarper.rb'


get '/' do 
  erb :index 
end


post '/result_page' do
  keyword = params[:name]
  scraper = Scraper.new(keyword)
  results = scraper.returnjobs
  erb :result_page, :locals => {:results => results}
end 

