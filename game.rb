require "sinatra"
require "sinc"
require "sinatra/reloader" if development?

enable :sessions
set :number_of_moves, 0

get "/" do
  settings.number_of_moves = 0
  session.clear
  erb :board
end

post "/" do
  (1..9).each do |num|
    session["space#{num}"] = params["space#{num}"] unless session["space#{num}"]
  end
  settings.number_of_moves += 1

  id = BestComputerMove.new(session, settings.number_of_moves).fetch_best_move
  session["space#{id}"] = "comp"

  erb :board
end

class BestComputerMove
  def initialize(board_hash, number_of_moves)
    @board = board_hash
    @move_num = number_of_moves
  end

  def fetch_best_move
    if @move_num == 1
      FirstComputerTurn.new(@board).return_best_move
    end
  end
end

class FirstComputerTurn
  def initialize(board_hash)
    @board = board_hash
  end

  def return_best_move
    @board[:space1] ? 5 : 1
  end
end

class SecondComputerTurn
  def initialize(board_hash)
    @board = board_hash
  end

  def return_best_move

  end
end
