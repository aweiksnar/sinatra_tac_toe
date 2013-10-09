require "sinatra"
require "sinc"
require "sinatra/reloader" if development?

enable :sessions

get "/" do
  session.clear
  erb :board
end

post "/" do
  (1..9).each do |num|
    session["space#{num}"] = params["space#{num}"] unless session["space#{num}"]
  end
  erb :board
end

