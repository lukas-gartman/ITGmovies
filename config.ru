#Use bundler to load gems
require 'bundler'

#Load gems from Gemfile
Bundler.require

#Load the app
require_relative 'app.rb'
require_relative 'utils/extensions.rb'
require_relative 'utils/QuickData.rb'
require_relative 'utils/account.rb'
require_relative 'utils/movie.rb'
require_relative 'utils/ticket.rb'
require_relative 'utils/salon.rb'
require_relative 'utils/show.rb'

#Slim HTML formatting
Slim::Engine.set_options pretty: true, sort_attrs: false

#FileUtils for handling file uploads
require 'fileutils'

#Run the app
run App
