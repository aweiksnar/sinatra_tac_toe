class RemainingComputerTurn
  include Helpers
  def initialize(board_hash)
    @board = board_hash
  end

  def return_best_move
    win_or_prevent("comp") || win_or_prevent("user") || make_alternate_move
  end

  private

  def make_alternate_move
    alt_move_options.each {|id| return id if open?(id)}
  end

  def alt_move_options
    [5,1,3,7,9,2,4,6,8]
  end
end
