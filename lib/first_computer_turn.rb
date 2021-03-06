class FirstComputerTurn
  def initialize(board_hash, move_num)
    @board = board_hash
    @move_num = move_num
  end

  def return_best_move
    comp_went_first ? corner_or_middle : top_left
  end

  private

  def comp_went_first
    @move_num > 0
  end

  def corner_or_middle
    @board["5"] ? 1 : 5
  end

  def top_left
    1
  end
end
