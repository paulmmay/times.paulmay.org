require './index'
require 'sinatra/activerecord/rake'
require './app/helpers.rb'

namespace :scheduled do
desc "Automatically update DB"
   task :autoupdate do
   autoUpdate
 end
desc "Automatically update images"
   task :updateimages do
   updateImages("http://www.irishtimes.com")
   updateImages("http://www.irishtimes.com/business")
   updateImages("http://www.irishtimes.com/sport")
end
end