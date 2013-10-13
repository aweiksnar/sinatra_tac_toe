class RemainingComputerTurn
  include Helpers

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
