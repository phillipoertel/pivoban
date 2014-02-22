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
require_relative 'lib/pivotal/story_activity_data'

# 
# configuration
# 
# http://www.sinatrarb.com/contrib/config_file.html
config = YAML.load_file('config/settings.yml')
PROJECT_ID = config['project_id']
TOKEN      = config['api_token']
set :slim, pretty: true

get '/' do
  slim :index
end

get '/story/:id' do
  @story = StoryActivityData.get(params[:id])
  slim :story
end

get '/bugs.json' do
  content_type :json
  BugData.load.to_json
end