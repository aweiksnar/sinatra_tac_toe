require "spec_helper"

describe SecondComputerTurn do
  let(:second_turn) {SecondComputerTurn.new({})}

  it "exists" do
    expect(second_turn).not_to be_nil
  end

  describe "#return_best_move" do
    it "exists" do
      expect(second_turn).to respond_to(:return_best_move)
    end

    it "moves in a corner if comp opened top-left and user went in the middle" do
      second_turn_after_top_left_open = SecondComputerTurn.new({"1" => "comp", "5" => "user" })
      expect(second_turn_after_top_left_open.return_best_move).to eq(9)

      second_turn_after_top_left_open_alt = SecondComputerTurn.new({"1" => "comp", "9" => "user" })
      expect(second_turn_after_top_left_open_alt.return_best_move).to eq(7)
    end

    describe "when computer went in middle space on previous turn" do
      diagonal_test_forks = [[6,1,9],[6,3,7]]
      diagonal_test_forks.each do |set|
        it "defends against diagonal forks #{set}" do
          diagonal_setup = SecondComputerTurn.new({"#{set[1]}" => "user", "#{set[2]}" => "user", "5" => "comp"})
          expect(diagonal_setup.return_best_move).to eq(set[0])
        end
      end

      outer_middle_test_pairs = [[3,2,6],[3,2,8],[1,2,4],[3,4,6],[7,4,8],[9,6,8]]
      outer_middle_test_pairs.each do |set|
        it "defends against outer middle pairs" do
          outer_middle_setup = SecondComputerTurn.new({"#{set[1]}" => "user", "#{set[2]}" => "user", "5" => "comp"})
          expect(outer_middle_setup.return_best_move).to eq(set[0])
        end
      end

      fourth_move_test_traps = [[2,4,9],[2,6,7],[4,2,9],[4,3,8],[6,1,8],[6,2,7],[8,1,6],[8,3,4]]
      fourth_move_test_traps.each do |set|
        it "defends against fourth move traps" do
          fourth_move_setup = SecondComputerTurn.new({"#{set[1]}" => "user", "#{set[2]}" => "user", "5" => "comp"})
          expect(fourth_move_setup.return_best_move).to eq(set[0])
        end
      end
    end
  end
end
