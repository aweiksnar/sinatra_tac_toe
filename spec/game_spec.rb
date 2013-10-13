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

describe SecondComputerTurn do
  let(:second_turn) {SecondComputerTurn.new({})}
  let(:second_turn_after_top_left_open) {SecondComputerTurn.new({"space1" => "comp", "space5" => "user" })}

  it "should exist" do
    expect(second_turn).not_to be_nil
  end

  describe "#return_best_move" do
    it "should exist" do
      expect(second_turn).to respond_to(:return_best_move)
    end

    it "should move in the bottom-left if comp opened top-left and user went in the middle" do
      expect(second_turn_after_top_left_open.return_best_move).to eq(7)
    end

    describe "when computer went in middle space on previous turn" do
      diagonal_test_forks = [[6,1,9],[6,3,7]]
      diagonal_test_forks.each do |set|
        it "should defend against diagonal forks #{set}" do
          diagonal_setup = SecondComputerTurn.new({"space#{set[1]}" => "user", "space#{set[2]}" => "user", "space5" => "comp"})
          expect(diagonal_setup.return_best_move).to eq(set[0])
        end
      end

      outer_middle_test_pairs = [[3,2,6],[3,2,8],[1,2,4],[3,4,6],[7,4,8],[9,6,8]]
      outer_middle_test_pairs.each do |set|
        it "should defend againse outer middle pairs" do
          outer_middle_setup = SecondComputerTurn.new({"space#{set[1]}" => "user", "space#{set[2]}" => "user", "space5" => "comp"})
          expect(outer_middle_setup.return_best_move).to eq(set[0])
        end
      end

      fourth_move_test_traps = [[2,4,9],[2,6,7],[4,2,9],[4,3,8],[6,1,8],[6,2,7],[8,1,6],[8,3,4]]
      fourth_move_test_traps.each do |set|
        it "should defend against fourth move traps" do
          fourth_move_setup = SecondComputerTurn.new({"space#{set[1]}" => "user", "space#{set[2]}" => "user", "space5" => "comp"})
          expect(fourth_move_setup.return_best_move).to eq(set[0])
        end
      end
    end
  end
end

describe CompleteRow do
  class TestClass
    include CompleteRow
    attr_accessor :board

    def initialize(board_hash)
      @board = board_hash
    end

    def self.all_the_rows
      [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[7,5,3]]
    end
  end

  let(:winners){TestClass.new({})}

  it "should exist" do
    expect(winners).not_to be_nil
  end

  describe "#win_or_prevent" do
    it {expect(winners).to respond_to(:win_or_prevent)}

    it "should return a space to move in if there are two x's or o's in a row" do
      expect(TestClass.new({"space1" => "user", "space2" => "user"}).win_or_prevent("user")).to eq(3)
    end

    describe "when given two equal spaces it should move in the third" do
      ids = [[0,1,2], [0,2,1], [1,0,2], [1,2,0], [2,0,1],[2,1,0]]
      ids.each_with_index do |set, index|
        it "should complete the row (variation: #{index})" do
          TestClass.all_the_rows.each do |row|
            expect(TestClass.new({"space#{row[set[2]]}" => "user", "space#{row[set[1]]}" => "user"}).win_or_prevent("user")).to eq(row[set[0]])
          end
        end
      end
    end
  end

  describe "#open" do
    it "should return false if space is occupied by user or comp" do
      expect(TestClass.new({}).open?("comp")).to eq(false)
      expect(TestClass.new({}).open?("user")).to eq(false)
    end

    it "should return true if the space is not taken by user or comp" do
      expect(TestClass.new({}).open?("test")).to eq(true)
    end
  end
end

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


