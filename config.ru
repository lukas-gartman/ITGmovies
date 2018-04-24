#Use bundler to load gems
require 'bundler'

#YAML for creating and parsing configs
require 'yaml'

#FileUtils for handling file uploads
require 'fileutils'

#Load gems from Gemfile
Bundler.require

#Load the app
require_relative 'app.rb'
require_relative 'utils/QuickData.rb'
Dir["utils/*.rb"].each do |file|
    require_relative file unless file == "QuickData.rb"
end

#Slim HTML formatting
Slim::Engine.set_options pretty: true, sort_attrs: false

#Load configs
$config = YAML.load_file('config/config.yml').freeze
if Sinatra::Base.development?
    args = $config['development']['database']
    QuickData.establish_connection(args)
elsif Sinatra::Base.production?
    args = $config['production']['database']
    QuickData.establish_connection(args)
end

#Run the app
run App
