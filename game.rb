require "sinatra"
require "sinatra/reloader" if development?

enable :sessions
set :number_of_moves, 0

get "/" do
  settings.number_of_moves = 0
  session.clear
  erb :board
end

post "/" do
  (1..9).each do |id|
    session["space#{id}"] = params["space#{id}"] unless session["space#{id}"]
  end
  settings.number_of_moves += 1

  id = BestComputerMove.new(session, settings.number_of_moves).fetch_best_move
  session["space#{id}"] = "comp"

  settings.number_of_moves += 1
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
    elsif @move_num == 3
      SecondComputerTurn.new(@board).return_best_move
    else
      RemainingComputerTurn.new(@board).return_best_move
    end
  end
end

class FirstComputerTurn
  def initialize(board_hash)
    @board = board_hash
  end

  def return_best_move
    @board[:space5] ? 1 : 5
  end
end

module CompleteRow
  def win_or_prevent(player)
    all_the_rows.each do |row|
      if @board["space#{row[0]}"] == player && @board["space#{row[1]}"] == player && open?(@board["space#{row[2]}"])
        return row[2]; break
      elsif @board["space#{row[0]}"] == player && @board["space#{row[2]}"] == player && open?(@board["space#{row[1]}"])
        return row[1]; break
      elsif @board["space#{row[1]}"] == player && @board["space#{row[2]}"] == player && open?(@board["space#{row[0]}"])
        return row[0]; break
      end
    end
    nil
  end

  def open?(space)
    space != "user" && space != "comp"
  end

  private

  def all_the_rows
    [
      [1,2,3],
      [4,5,6],
      [7,8,9],
      [1,4,7],
      [2,5,8],
      [3,6,9],
      [1,5,9],
      [7,5,3]
    ]
  end
end

class SecondComputerTurn
  include CompleteRow
  def initialize(board_hash)
    @board = board_hash
  end

  def return_best_move
    if win_or_prevent("user")
      win_or_prevent("user")
    elsif @board["space5"] == "comp"
      board_layouts.each do |set|
        return set[0] if @board["space#{set[1]}"] == "user" && @board["space#{set[2]}"] == "user"
      end
    else
      7
    end
  end

  private

  def board_layouts
    fourth_move_traps + diagonal_forks + outer_middle_pairs
  end

  def fourth_move_traps
    [         #array[0] is optimal move for computer
      [2,4,9],
      [2,6,7],
      [4,2,9],
      [4,3,8],
      [6,1,8],
      [6,2,7],
      [8,1,6],
      [8,3,4]
    ]
  end

  def diagonal_forks
    [         #array[0] is optimal move for computer
      [6,1,9],
      [6,3,7]
    ]
  end

  def outer_middle_pairs
    [         #array[0] is optimal move for computer
      [3,2,6],
      [3,2,8],
      [1,2,4],
      [3,4,6],
      [7,4,8],
      [9,6,8]
    ]
  end
end

class RemainingComputerTurn
  include CompleteRow

  def initialize(board_hash)
    @board = board_hash
  end

  def return_best_move
    if win_or_prevent("comp")
      win_or_prevent("comp")
    elsif win_or_prevent("user")
      win_or_prevent("user")
    else
      alt_move_options.each do |id|
        return id if open?(@board["space#{id}"])
      end
    end
  end

  private

  def alt_move_options
    [5,1,3,7,9,2,4,6,8]
  end
end
