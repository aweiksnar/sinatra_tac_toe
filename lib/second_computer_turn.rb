class SecondComputerTurn
  include Helpers
  def initialize(board_hash)
    @board = board_hash
  end

  def return_best_move
    win_or_prevent("user") || computer_picked_middle_first || play_an_open_corner
  end

  private

  def computer_picked_middle_first
    board_layouts.each do |set|
      return set[0] if filled?(set[1], "user") && filled?(set[2], "user")
    end
    false
  end

  def play_an_open_corner
    corners.each {|corner| return corner if open?(corner)}
  end

  def board_layouts
    fourth_move_traps + diagonal_forks + outer_middle_pairs
  end

  def corners
    [9,7,3,1]
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
