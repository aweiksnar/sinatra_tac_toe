require "spec_helper"

describe FirstComputerTurn do
  let(:first_turn_top_left) {FirstComputerTurn.new({:space1 => "user"})}
  let(:first_turn_center) {FirstComputerTurn.new({:space5 => "user"})}

  it "should exist" do
    expect(first_turn_center).not_to be_nil
    expect(first_turn_top_left).not_to be_nil
  end

  describe "#return_best_move" do
    it "center if it's open" do
      expect(first_turn_top_left.return_best_move).to eq(5)
    end

    it "top left corner if center is filled" do
      expect(first_turn_center.return_best_move).to eq(1)
    end
  end
end
