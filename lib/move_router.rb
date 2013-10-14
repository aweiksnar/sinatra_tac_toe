class MoveRouter
  include Helpers
  def initialize(board_hash, number_of_moves)
    @board = board_hash
    @move_num = number_of_moves
  end

  def fetch_best_move
    if @move_num < 2
      FirstComputerTurn.new(@board, @move_num).return_best_move
    elsif @move_num < 4
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
    all_the_rows.each {|row| return true if all_spaces_filled(row, "comp")}
    false
  end

  def all_spaces_filled(row, player)
    filled?(row[0], "comp") && filled?(row[1], "comp") && filled?(row[2], "comp")
  end
end
