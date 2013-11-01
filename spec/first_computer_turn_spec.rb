require "spec_helper"

describe FirstComputerTurn do
  let(:first_turn_top_left) {FirstComputerTurn.new({"1" => "user"},1)}
  let(:first_turn_center) {FirstComputerTurn.new({"5" => "user"},1)}
  let(:first_turn_open_board){FirstComputerTurn.new({},0)}

  it "exists" do
    expect(first_turn_center).not_to be_nil
    expect(first_turn_top_left).not_to be_nil
  end

  describe "#return_best_move" do
    describe "if user went first" do
      it "center if it's open" do
        expect(first_turn_top_left.return_best_move).to eq(5)
      end

      it "top left corner if center is filled" do
        expect(first_turn_center.return_best_move).to eq(1)
      end
    end

    describe "if computer goes first" do
      it "goes in the corner" do
        expect(first_turn_open_board.return_best_move).to eq(1)
      end
    end
  end
end
