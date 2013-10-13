module Helpers
  def win_or_prevent(player)
    all_the_rows.each do |row|
      if @board["space#{row[0]}"] == player && @board["space#{row[1]}"] == player && open?(@board["space#{row[2]}"])
        return row[2]; break
      elsif @board["space#{row[0]}"] == player && @board["space#{row[2]}"] == player && open?(@board["space#{row[1]}"])
        return row[1]; break
      elsif @board["space#{row[1]}"] == player && @board["space#{row[2]}"] == player && open?(@board["space#{row[0]}"])
        return row[0]; break
      end
    end
    nil
  end

  def open?(space)
    space != "user" && space != "comp"
  end

  private

  def all_the_rows
    [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[7,5,3]]
  end
end
