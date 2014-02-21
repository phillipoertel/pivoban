require 'sinatra'
require "slim"
require "sinatra/reloader" if development?
require "sinatra/config_file"

# http://www.sinatrarb.com/contrib/config_file.html
config_file 'config/settings.yml'

get '/' do
  settings.project_id
  #slim :index
end