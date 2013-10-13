require "spec_helper"

describe RemainingComputerTurn do
  let(:remaining_turn){RemainingComputerTurn.new({})}
  let(:remaining_turn_comp_win){RemainingComputerTurn.new({"space1" => "comp", "space2" => "comp", })}
  let(:remaining_turn_user_block){RemainingComputerTurn.new({"space1" => "user", "space5" => "user"})}
  let(:remaining_turn_alt_move){RemainingComputerTurn.new({"space1" => "user", "space2" => "comp", "space3" => "user", "space4" => "comp", "space5" => "user", "space6" => "comp",  "space7" => "user", "space9" => "comp"})}

  it "should exist" do
    expect(remaining_turn).not_to be_nil
  end

  describe "#return_best_move" do
    it {expect(remaining_turn).to respond_to(:return_best_move)}

    it "should win the game if it can" do
      expect(remaining_turn_comp_win.return_best_move).to eq(3)
    end

    it "should prevent the computer from winning the game if it can" do
      expect(remaining_turn_user_block.return_best_move).to eq(9)
    end

    it "should move in an open space if there is nothing to defend" do
      expect(remaining_turn_alt_move.return_best_move).to eq(8)
    end
  end
end
