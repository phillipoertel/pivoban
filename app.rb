require 'sinatra'
require "slim"
require "json"
require "sinatra/reloader" if development?
require "sinatra/config_file"

# http://www.sinatrarb.com/contrib/config_file.html
config_file 'config/settings.yml'
set :slim, pretty: true

get '/' do
  @settings = settings
  slim :index
end

get '/bugs.json' do
  content_type :json
  File.read('public/stackedAreaData.json')
  #[[1,2,3],[2,4,6]].to_json

end