class MoveRouter
  include Helpers
  def initialize(board_hash, number_of_moves)
    @board = board_hash
    @move_num = number_of_moves
  end

  def fetch_best_move
    first_comp_move || second_comp_move || remaining_comp_move
  end

  def game_over?
    three_in_a_row? || @move_num > 8
  end

  private

  def first_comp_move
    FirstComputerTurn.new(@board, @move_num).return_best_move if @move_num < 2
  end

  def second_comp_move
    SecondComputerTurn.new(@board).return_best_move if @move_num < 4
  end

  def remaining_comp_move
    RemainingComputerTurn.new(@board).return_best_move
  end

  def three_in_a_row?
    all_the_rows.each {|row| return true if all_spaces_filled(row, "comp")}
    false
  end

  def all_spaces_filled(row, player)
    filled?(row[0], "comp") && filled?(row[1], "comp") && filled?(row[2], "comp")
  end
end
