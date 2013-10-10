require "spec_helper"

describe "The tic tac toe game" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "should have a board layout" do
    get "/"
    expect(last_response).to be_ok
  end

  it "should accept posts to the board" do
    post "/"
    expect(last_response).to be_ok
  end
end

describe BestComputerMove do
  let(:comp) {BestComputerMove.new({}, 1)}

  it "should exist" do
    expect(comp).not_to be_nil
  end

  describe "#fetch_best_move" do
    it "should exist" do
      expect(comp).to respond_to(:fetch_best_move)
    end

    it "should return a number" do
      expect(comp.fetch_best_move.is_a? Fixnum).to eq(true)
    end
  end
end

describe FirstComputerTurn do
  let(:first_turn_middle) {FirstComputerTurn.new({:space5 => "user"})}
  let(:first_turn_top_left) {FirstComputerTurn.new({:space1 => "user"})}

  it "should exist" do
    expect(first_turn_middle).not_to be_nil
    expect(first_turn_top_left).not_to be_nil
  end

  describe "#return_best_move" do
    it "top left if its open" do
      expect(first_turn_middle.return_best_move).to eq(1)
    end

    it "middle if the top_left is filled" do
      expect(first_turn_top_left.return_best_move).to eq(5)
    end
  end
end

describe SecondComputerTurn do
  let(:second_turn) {SecondComputerTurn.new({})}

  it "should exist" do
    expect(second_turn).not_to be_nil
  end

  describe "#return_best_move" do
    it "shoudld exist" do
      expect(second_turn).to respond_to(:return_best_move)
    end
  end
end
