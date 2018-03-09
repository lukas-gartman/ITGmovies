#Use bundler to load gems
require 'bundler'

#Load gems from Gemfile
Bundler.require

#Load the app
require_relative 'app.rb'
require_relative 'utils/QuickData.rb'
require_relative 'utils/account.rb'
require_relative 'utils/movie.rb'

#Slim HTML formatting
Slim::Engine.set_options pretty: true, sort_attrs: false

#FileUtils for handling file uploads
require 'fileutils'

#Run the app
run App
