require 'bundler'
require 'open-uri'
Bundler.require

configure do |c|
  # enable :sessions
  set :root, File.dirname(__FILE__)
  set :views, Proc.new{ File.join(root, "app", "views")}
  set :scss, :style => :compact
  ActiveRecord::Base.include_root_in_json = false
end

configure :development, :test do
set :database, 'sqlite3://db/development.sqlite'
end

configure :production do
  # Database connection
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )
end

require './app/models'
require './app/routes'
require './app/helpers'