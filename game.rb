require "sinatra"

require "./lib/helpers.rb"
require "./lib/first_computer_turn.rb"
require "./lib/remaining_computer_turn.rb"
require "./lib/second_computer_turn.rb"
require "./lib/move_router.rb"
require "./lib/game_controller.rb"

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
