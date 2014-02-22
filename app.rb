#
# require libraries
#
require 'sinatra'
require "slim"
require "json"
require "sinatra/reloader" if development?
require "sinatra/config_file"

#
# require own classes
#
require_relative 'lib/bug_data'

# 
# configuration
# 
# http://www.sinatrarb.com/contrib/config_file.html
config_file 'config/settings.yml'
set :slim, pretty: true

get '/' do
  @settings = settings
  slim :index
end

get '/bugs.json' do
  content_type :json
  BugData.load.to_json
end