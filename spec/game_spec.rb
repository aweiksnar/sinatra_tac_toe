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

describe "the computer player" do
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

describe "FirstTurn" do
  let(:first_turn_middle) {FirstTurn.new({:space5 => "user"})}
  let(:first_turn_top_left) {FirstTurn.new({:space1 => "user"})}

  describe "#get_best_move" do
    it "top left if its open" do
      expect(first_turn_middle.get_best_move).to eq(1)
    end

    it "middle if the top_left is filled" do
      expect(first_turn_top_left.get_best_move).to eq(5)
    end
  end
end
