class FirstComputerTurn
  def initialize(board_hash)
    @board = board_hash
  end

  def return_best_move
    @board[:space5] ? 1 : 5
  end
end
