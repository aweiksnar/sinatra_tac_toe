class SecondComputerTurn
  include Helpers
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
    [[2,4,9],[2,6,7],[4,2,9],[4,3,8],[6,1,8],[6,2,7],[8,1,6],[8,3,4]]
  end

  def diagonal_forks
    [[6,1,9],[6,3,7]]
  end

  def outer_middle_pairs
    [[3,2,6],[3,2,8],[1,2,4],[3,4,6],[7,4,8],[9,6,8]]
  end
end
