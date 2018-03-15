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
require_relative 'utils/extensions.rb'
require_relative 'utils/QuickData.rb'
require_relative 'utils/account.rb'
require_relative 'utils/movie.rb'
require_relative 'utils/ticket.rb'
require_relative 'utils/salon.rb'
require_relative 'utils/show.rb'

#Slim HTML formatting
Slim::Engine.set_options pretty: true, sort_attrs: false

#Load configs
config = YAML.load_file('config/config.yml')
if Sinatra::Base.development?
    args = config['development']['database']
    QuickData.setup(args)
elsif Sinatra::Base.production?
    args = config['production']['database']
    QuickData.setup(args)
end
p Sinatra::Base.development?
#Run the app
run App
