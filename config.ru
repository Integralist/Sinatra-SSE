require "sinatra/base"
require "./controllers/app.rb"

map("/") { run App }
