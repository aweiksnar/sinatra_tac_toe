class MoveRouter
  include Helpers
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

  def game_over?
    three_in_a_row? || @move_num > 8
  end

  private

  def three_in_a_row?
    all_the_rows.each do |row|
      if filled?(row[0], "comp") && filled?(row[1], "comp") && filled?(row[2], "comp")
        return true ; break
      end
    end
    false
  end
end
