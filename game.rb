require "sinatra"
require "sinatra/reloader" if development?

get "/" do
  "Welcome to tic-tac-toe"
end
