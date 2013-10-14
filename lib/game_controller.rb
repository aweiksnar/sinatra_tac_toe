module Sinatra
  module GameController
    def alternate_first_move
      if settings.game_num % 2 == 0
        id = MoveRouter.new(session, settings.number_of_moves).fetch_best_move
        session["space#{id}"] = "comp"
        settings.number_of_moves += 1
      end
    end

    def reset_game
      settings.number_of_moves = 0
      settings.game_num += 1
      session.clear
    end

    def make_user_move(params)
      (1..9).each do |id|
        session["space#{id}"] = params["space#{id}"] unless session["space#{id}"]
      end
      settings.number_of_moves += 1
    end

    def get_computer_move
      id = MoveRouter.new(session, settings.number_of_moves).fetch_best_move
      session["space#{id}"] = "comp"
      settings.number_of_moves += 1
      @game_over = MoveRouter.new(session, settings.number_of_moves).game_over?
    end
  end
  helpers GameController
end

