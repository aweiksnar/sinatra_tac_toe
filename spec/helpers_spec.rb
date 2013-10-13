require "spec_helper"

describe Helpers do
  class TestClass
    include Helpers
    attr_accessor :board

    def initialize(board_hash)
      @board = board_hash
    end

    def self.all_the_rows
      [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[7,5,3]]
    end
  end

  let(:helpers_test_class){TestClass.new({})}

  it "should exist" do
    expect(helpers_test_class).not_to be_nil
  end

  describe "#win_or_prevent" do
    it {expect(helpers_test_class).to respond_to(:win_or_prevent)}

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
