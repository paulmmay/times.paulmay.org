require 'bundler'
require 'open-uri'
Bundler.require

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :port     => db.port,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)

configure do |c|
  # enable :sessions
  set :root, File.dirname(__FILE__)
  set :views, Proc.new{ File.join(root, "app", "views")}
  set :scss, :style => :compact
  set :database, ENV['DATABASE_URL'] || "sqlite3://db/development.sqlite"
  ActiveRecord::Base.include_root_in_json = false
end

require './app/models'
require './app/routes'
require './app/helpers'