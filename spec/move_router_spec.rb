require "spec_helper"

describe MoveRouter do
  let(:comp) {MoveRouter.new({}, 1)}
  let(:comp_win) {MoveRouter.new({"space1" => "comp", "space5" => "comp", "space9" => "comp" ,"space2" => "user"}, 4)}
  let(:comp_win_alt) {MoveRouter.new({"space4" => "comp", "space5" => "comp", "space6" => "comp" ,"space2" => "user"}, 4)}

  it "should exist" do
    expect(comp).not_to be_nil
  end

  describe "#fetch_best_move" do
    it{expect(comp).to respond_to(:fetch_best_move)}

    it "should return a number" do
      expect(comp.fetch_best_move.is_a? Fixnum).to eq(true)
    end

    it "should return the first move if move num is less than 2" do
      move = MoveRouter.new({},0).fetch_best_move
      expect(move).to eq(1)
    end

    it "should return the second comp move if move num is less than 4" do
      move = MoveRouter.new({"space4" => "user", "space9" => "user", "space5" => "comp"}, 3).fetch_best_move
      expect(move).to eq(2)
    end

    it "should return a non first or second comp move if move num is >= 4" do
      move = MoveRouter.new({"space4" => "user", "space9" => "user", "space5" => "comp", "space2" => "comp"}, 4).fetch_best_move
      expect(move).to eq(8)
    end
  end

  describe "#game_over?" do
    it{expect(comp).to respond_to(:game_over?)}

    it "should return false if the game is not over" do
      expect(comp.game_over?).to eq(false)
    end

    it "should return true if there are three in a row" do
      expect(comp_win.game_over?).to eq(true)
      expect(comp_win_alt.game_over?).to eq(true)
    end
  end
end
