require 'sinatra'
require "slim"
require "sinatra/reloader" if development?

get '/' do
  slim :index
end