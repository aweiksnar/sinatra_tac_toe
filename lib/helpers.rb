module Helpers
  def win_or_prevent(player)
    all_the_rows.each do |row|
      if filled?(row[0], player) && filled?(row[1], player) && open?(row[2])
        return row[2]; break
      elsif filled?(row[0], player) && filled?(row[2], player) && open?(row[1])
        return row[1]; break
      elsif filled?(row[1], player) && filled?(row[2], player) && open?(row[0])
        return row[0]; break
      end
    end
    nil
  end

  def open?(id)
    @board["space#{id}"] != "user" && @board["space#{id}"] != "comp"
  end

  def filled?(id, player)
    @board["space#{id}"] == player
  end

  private  # make row_needs_to_be_completed(player, args || rows) || complete_possible_rows(player)

  def all_the_rows
    [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[7,5,3]]
  end
end
