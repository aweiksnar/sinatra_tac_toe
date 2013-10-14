class RemainingComputerTurn
  include Helpers

  def initialize(board_hash)
    @board = board_hash
  end

  def return_best_move
    if win_or_prevent("comp") || win_or_prevent("user")
      win_or_prevent("comp") || win_or_prevent("user")
    else
      make_alternate_move
    end
  end

  private

  def make_alternate_move
    alt_move_options.each do |id|
      return id if open?(id)
    end
  end

  def alt_move_options
    [5,1,3,7,9,2,4,6,8]
  end
end
