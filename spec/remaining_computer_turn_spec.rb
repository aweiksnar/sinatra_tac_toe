require "spec_helper"

describe RemainingComputerTurn do
  let(:remaining_turn){RemainingComputerTurn.new({})}

  it "should exist" do
    expect(remaining_turn).not_to be_nil
  end

  describe "#return_best_move" do
    it {expect(remaining_turn).to respond_to(:return_best_move)}

    all_the_rows = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[7,5,3]]

    all_the_rows.each do |row|
      it "wins the game if it can row:#{row}" do
        turn = RemainingComputerTurn.new({"#{row[0]}" => "comp", "#{row[1]}" => "comp"})
        expect(turn.return_best_move).to eq(row[2])
      end
    end

    all_the_rows.each do |row|
      it "prevents the computer from winning the game if it can" do
        turn = RemainingComputerTurn.new({"#{row[0]}" => "user", "#{row[1]}" => "user"})
        expect(turn.return_best_move).to eq(row[2])
      end
    end

    it "moves in an open space if there is nothing to defend" do
      turn = RemainingComputerTurn.new({"1" => "user", "2" => "comp", "3" => "user", "4" => "comp", "5" => "user", "6" => "comp",  "7" => "user", "9" => "comp"})
      expect(turn.return_best_move).to eq(8)
    end
  end
end
