require "spec_helper"

describe Sinatra::GameController do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it{expect(Sinatra::GameController).not_to be_nil}

  describe "#alternate_first_move" do
    it "should add 1 to the number of moves" do
      get "/"
      expect(app.settings.number_of_moves).to eq(0)
      get "/"
      expect(app.settings.number_of_moves).to eq(1)
    end
  end

  describe "#reset_game" do
    it "should reset the number of moves to 0" do
      app.settings.number_of_moves = 2
      get "/"
      expect(app.settings.number_of_moves).to eq(0)
    end

    it "should increase the game number by 1" do
      app.settings.game_num = 0
      get "/"
      expect(app.settings.game_num).to eq(1)
    end
  end

  describe "posting to the board" do
    it "should make a user move and a computer move" do
      app.settings.number_of_moves = 0
      post "/"
      expect(app.settings.number_of_moves).to eq(2)
    end
  end
end