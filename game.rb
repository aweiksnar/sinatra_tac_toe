require "sinatra"
require "sinatra/reloader" if development?

get "/" do
  erb :board
end

post "/" do
  puts params
  erb :board
end
