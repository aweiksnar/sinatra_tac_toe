require "sinatra"

Dir["./lib/*.rb"].each {|file| require file }

enable :sessions

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
