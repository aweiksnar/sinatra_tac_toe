require "sinatra"
require "sinatra/reloader" if development?

Dir["./lib/*.rb"].each {|file| require file }

enable :sessions
set :number_of_moves, 0
set :game_num, 0

get "/" do
  reset_game
  alternate_first_move
  erb :board
end

post "/" do
  make_user_move(params)
  get_computer_move
  erb :board
end
