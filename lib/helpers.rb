module Helpers
  def win_or_prevent(player)
    all_the_rows.each {|row| @move_id = complete_row(row, player)}
    @move_id
  end

  def open?(id)
    @board["space#{id}"] != "user" && @board["space#{id}"] != "comp"
  end

  def filled?(id, player)
    @board["space#{id}"] == player
  end

  private

  def complete_row(row, player)
    row_order_combos.each {|set| @id = row[set[2]] if any_doubles?(row, set, player)}
    @id
  end

  def any_doubles?(row, set, player)
    filled?(row[set[0]], player) && filled?(row[set[1]], player) && open?(row[set[2]])
  end

  def row_order_combos
    [[0,1,2],[0,2,1],[1,2,0]]
  end

  def all_the_rows
    [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[7,5,3]]
  end
end
