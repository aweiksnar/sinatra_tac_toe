module Sinatra
  module GameController
    def alternate_first_move
      if session[:game_num] % 2 == 0
        assign_computer_move_to_board
        session[:number_of_moves] += 1
      end
    end

    def reset_game
      clear_board
      session[:number_of_moves] = 0
      increment_game_num
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
      (1..9).each {|id| session["#{id}"] = nil}
    end

    def assign_computer_move_to_board
      id = MoveRouter.new(session, session[:number_of_moves]).fetch_best_move
      session["#{id}"] = "comp"
    end

    def increment_game_num
      session[:game_num] = 0 unless session[:game_num]
      session[:game_num] += 1
    end

    def assign_user_move_to_board
      (1..9).each {|id| session["#{id}"] = params["#{id}"] unless session["#{id}"]}
    end
  end
  helpers GameController
end
