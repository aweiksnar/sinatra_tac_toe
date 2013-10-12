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
  (1..9).each do |num|
    session["space#{num}"] = params["space#{num}"] unless session["space#{num}"]
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
      SecondComputerTurn.new(@board).return_best_move  # add elsif winoorpp like other method, then else random
    end
  end
end

class FirstComputerTurn
  def initialize(board_hash)
    @board = board_hash
  end

  def return_best_move
    @board[:space5] ? 1 : 5   # Comp should go in middle if user goes in corner, and corner if middle
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

  private

  def open?(space)
    space != "user" && space != "comp"
  end

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
      9
    end
  end

  private      # add all possible moves to loop through so it can be one loop (concat the arrays)

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

# make 'random move generator go through logical move steps'
