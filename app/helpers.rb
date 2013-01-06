#------------------------------------------------------------------------#
# Irish Times Tool
# Paul May, 2013
#------------------------------------------------------------------------#

#------------------------------------------------------------------------#
# autoUpdate
# Description: The core update function - run queries, save results
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
