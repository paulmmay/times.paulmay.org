#------------------------------------------------------------------------#
# Irish Times Tools
# Paul May, 2013
#------------------------------------------------------------------------#

#------------------------------------------------------------------------#
# autoUpdate
# Description: Get the home page and the main business page
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
# Description: The core update function - run queries, save results
#------------------------------------------------------------------------#
def updateImages
   #Updatetimestamp.create(:updated=>Time.now,:status=>true)
   puts "updateImages started at #{Time.now}"
   uri_home = "http://www.irishtimes.com"
   begin
	   source_home = getData(uri_home)
	   html_doc = Nokogiri::HTML(source_home)
	   #-------------------------- Elements --------------------------------#	   
	   image_url = html_doc.at_css('div.index_story').at_css("img")["src"]
	   image_link = html_doc.at_css('div.index_story').at_css("a")['href']
	   image_caption = html_doc.at_css('div.index_story').at_css("img")["title"]
	   #remove image_url timestamp
	   #image_url = image_url[0..image_url.index("?")-1]

	   #--------------------------------------------------------------------#	
	   t = Timesimage.where(:image_url =>image_url).first_or_create(:updated=>Time.now,:image_url=>image_url,:image_caption=>image_caption,:image_link=>image_link)
	   puts "updateImages finished at #{Time.now}"
	   true
   rescue Exception=>e
      puts e
      false
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
