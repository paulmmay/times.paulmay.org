#--------------------------------------------------------------------------------------------------------------#
# Irish Times Tools
# Paul May, 2013
#--------------------------------------------------------------------------------------------------------------#

#==================================== Sinatra and Heroku DB Configuration ==================================== #

require 'bundler'
require 'open-uri'
require 'sinatra/activerecord'

Bundler.require

configure do |c|
  # enable :sessions
  set :root, File.dirname(__FILE__)
  set :views, Proc.new{ File.join(root, "views")}
  set :scss, :style => :compact
  ActiveRecord::Base.include_root_in_json = false
end

configure :development, :test do
set :database, 'sqlite3://db/development.sqlite'
end

configure :production do
  # Database connection
  db = URI.parse(ENV['DATABASE_URL'])
  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )
end

#================================================ Helpers ================================================#

#------------------------------------------------------------------------#
# autoUpdate
# Description: Get the home page and the business page
#------------------------------------------------------------------------#
def autoUpdate
   #Updatetimestamp.create(:updated=>Time.now,:status=>true)
   puts "autoUpdate started at #{Time.now}"
   uri_home = "http://www.irishtimes.com"
   uri_business = "http://www.irishtimes.com/business/"
   begin
	   source_home = getData(uri_home)
	   source_business = getData(uri_business)
	   t = Timespage.create(:updated=>Time.now,:page_source=>source_home,:url=>uri_home)
	   t = Timespage.create(:updated=>Time.now,:page_source=>source_business,:url=>uri_business)
	   #Updatetimestamp.create(:updated=>Time.now,:status=>false)
	   puts "autoUpdate finished at #{Time.now}"
	   true
   rescue Exception=>e
      puts e
      false
   end
end

#------------------------------------------------------------------------#
# updateImages
# Description: The core update function - get links to images.
#------------------------------------------------------------------------#
def updateImages(_uri)
   #Updatetimestamp.create(:updated=>Time.now,:status=>true)
   puts "updateImages started at #{Time.now}"
	   source_home = getData(_uri)
	   html_doc = Nokogiri::HTML(source_home)
	   #-------------------------- Elements --------------------------------#	   
	   stories = html_doc.css('div.story');
	   stories.each do |story|
	   begin
		   image_url = story.at_css("img")["src"]
		   image_credit = story.at_css("img")["title"]
		   image_url = image_url.sub("box_620_330","box_600") #swap out for a higher res image
		   image_url = image_url.sub("box_460_245","box_600") #swap out for a higher res image - second case
		   image_url = image_url.sub("box_140","box_600") #swap out for a higher res image - third case
		   image_url = image_url.sub("box_300","box_600") #swap out for a higher res image - fourth case
		   image_url = image_url.sub("box_220","box_600") #swap out for a higher res image - fourth case
		   image_link = story.at_css("a")['href']
		   image_link = image_link.gsub! /\t/, ''
		   image_caption = story.at_css("span").text
		   t = Timesimage.where(:image_link =>image_link).first_or_create(:updated=>Time.now,:image_url=>image_url,:image_caption=>image_caption,:image_link=>image_link,:image_credit=>image_credit)
		rescue Exception=>e
		puts e
		end
	  end
end

#------------------------------------------------------------------------#
# getData
# Description: Gets data from a URL and converts it from XML into a hash
#------------------------------------------------------------------------#
def getData(location)
   # get the XML and turn it into a hash
   uri = URI.parse(location)
   str = uri.read
   return str
   #data = Hash.from_xml(str)
   #return data
end

#================================================ Routes ================================================#

not_found do
  erb :notfound
end

get '/' do
	@result = Timesimage.find(:all, :order => "id desc", :limit => 60)
	erb :last60
end

#================================================ Models ================================================#


class Timespage < ActiveRecord::Base

end

class Timesimage < ActiveRecord::Base

end