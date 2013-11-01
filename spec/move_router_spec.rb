require "spec_helper"

describe MoveRouter do
  let(:comp) {MoveRouter.new({}, 1)}

  it "exists" do
    expect(comp).not_to be_nil
  end

  describe "#fetch_best_move" do
    it{expect(comp).to respond_to(:fetch_best_move)}

    it "returns a number" do
      expect(comp.fetch_best_move.is_a? Fixnum).to eq(true)
    end

    it "returns the first move if move num is less than 2" do
      move = MoveRouter.new({},0).fetch_best_move
      expect(move).to eq(1)
    end

    it "returns the second comp move if move num is less than 4" do
      move = MoveRouter.new({"4" => "user", "9" => "user", "5" => "comp"}, 3).fetch_best_move
      expect(move).to eq(2)
    end

    it "returns a non first or second comp move if move num is >= 4" do
      move = MoveRouter.new({"4" => "user", "9" => "user", "5" => "comp", "2" => "comp"}, 4).fetch_best_move
      expect(move).to eq(8)
    end
  end

  describe "#game_over?" do
    it{expect(comp).to respond_to(:game_over?)}

    it "returns false if the game is not over" do
      expect(comp.game_over?).to eq(false)
    end

    it "returns true if there are three in a row" do
      comp_win = MoveRouter.new({"1" => "comp", "5" => "comp", "9" => "comp" ,"2" => "user"}, 4)
      expect(comp_win.game_over?).to eq(true)

      comp_win_alt = MoveRouter.new({"4" => "comp", "5" => "comp", "6" => "comp" ,"2" => "user"}, 4)
      expect(comp_win_alt.game_over?).to eq(true)
    end
  end
end
