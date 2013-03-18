require './index'
require 'sinatra/activerecord/rake'

/* 
I use Heroku Scheduler to call scheduled:autoupdate and scheduled:updateimages periodically.
*/
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
   updateImages("http://www.irishtimes.com")
end
end