ENV['RACK_ENV'] = 'test'

require "./game.rb"
require "rspec"
require "rack/test"
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

end
