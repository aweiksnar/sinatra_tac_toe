require "sinatra"
require "sinatra/reloader" if development?

Dir["./lib/*.rb"].each {|file| require file }

enable :sessions
set :number_of_moves, 0

get "/" do
  settings.number_of_moves = 0
  session.clear
  erb :board
end

post "/" do
  (1..9).each do |id|
    session["space#{id}"] = params["space#{id}"] unless session["space#{id}"]
  end
  settings.number_of_moves += 1

  id = MoveRouter.new(session, settings.number_of_moves).fetch_best_move
  session["space#{id}"] = "comp"

  settings.number_of_moves += 1

  @game_over = MoveRouter.new(session, settings.number_of_moves).game_over?

  erb :board
end
