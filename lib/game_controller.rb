module Sinatra
  module GameController
    def alternate_first_move
      if settings.game_num % 2 == 0
        assign_computer_move_to_board
        settings.number_of_moves += 1
      end
    end

    def reset_game
      settings.number_of_moves = 0
      settings.game_num += 1
      session.clear
    end

    def make_user_move(params)
      assign_user_move_to_board
      settings.number_of_moves += 1
    end

    def get_computer_move
      assign_computer_move_to_board
      settings.number_of_moves += 1
      @game_over = MoveRouter.new(session, settings.number_of_moves).game_over?
    end

    private

    def assign_computer_move_to_board
      id = MoveRouter.new(session, settings.number_of_moves).fetch_best_move
      session["space#{id}"] = "comp"
    end

    def assign_user_move_to_board
      (1..9).each {|id| session["space#{id}"] = params["space#{id}"] unless session["space#{id}"]}
    end

  end
  helpers GameController
end

