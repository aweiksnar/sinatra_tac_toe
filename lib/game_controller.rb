module Sinatra
  module GameController
    def alternate_first_move
      if settings.game_num % 2 == 0
        assign_computer_move_to_board
        session[:number_of_moves] += 1             #  session[:game_num] = 0 unless session[:game_num]
      end
    end

    def reset_game
      clear_board                    #change to #clear_board which loops 1..9 and sets to nil so gamenum can increment
      session[:number_of_moves] = 0
      settings.game_num += 1
    end

    def make_user_move(params)
      assign_user_move_to_board
      session[:number_of_moves] += 1
    end

    def get_computer_move
      assign_computer_move_to_board
      session[:number_of_moves] += 1
      @game_over = MoveRouter.new(session, session[:number_of_moves]).game_over?
    end

    private

    def clear_board
      (1..9).each {|id| session["space#{id}"] = nil}
    end

    def assign_computer_move_to_board
      id = MoveRouter.new(session, session[:number_of_moves]).fetch_best_move
      session["space#{id}"] = "comp"
    end

    def assign_user_move_to_board
      (1..9).each {|id| session["space#{id}"] = params["space#{id}"] unless session["space#{id}"]}
    end
  end
  helpers GameController
end

