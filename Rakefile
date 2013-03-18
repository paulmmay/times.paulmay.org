require './index'
require 'sinatra/activerecord/rake'

namespace :scheduled do
desc "Automatically update DB"
   task :autoupdate do
   autoUpdate
 end
desc "Automatically update images"
   task :updateimages do
   updateImages("http://www.irishtimes.com/business")
   updateImages("http://www.irishtimes.com/culture")
   updateImages("http://www.irishtimes.com/sport")
   updateImages("http://www.irishtimes.com/news")
   updateImages("http://www.irishtimes.com/news/world")
   updateImages("http://www.irishtimes.com")
end
end