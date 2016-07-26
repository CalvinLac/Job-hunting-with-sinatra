require 'mechanize'
require 'pry'
require 'csv'
# require './locator.rb'

Job=Struct.new(:title,:company,:link, :location)

class Scraper

  def initialize(keyword)
    @jobarray=[]

    scraper= Mechanize.new
    scraper.history_added = Proc.new { sleep 0.5 }

    page=scraper.get("http://www.dice.com/")
    result=page.input_with(:id=>'search-field-keyword')
    result.q=keyword
    # result_location = page.form_with(:id =>'search-field-location')
    # result_location.q='Calgary'
    # button = page.form_with(:class => 'btn btn-primary') 

    result_page = scraper.submit(submit)

    page.links_with(:href => /detail/).each do |link|
      if @jobarray.size >1
        break
      else
      current_job=Job.new
      current_job.title=link.text.strip

      description_page=link.click
      holder =description_page.link_with(:href => /company/) 
      current_job.company=holder.text
      current_job.link=link
      current_job.location = description_page.search("li.location").text
      @jobarray<<current_job
      end
    end
  end

  def returnjobs
    @jobarray
  end
end

s = Scraper.new("accounting")
puts s.returnjobs