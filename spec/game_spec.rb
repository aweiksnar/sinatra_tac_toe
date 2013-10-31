require "spec_helper"

describe "The tic tac toe game" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "has a board layout" do
    get "/"
    expect(last_response).to be_ok
  end

  it "accepts posts to the board" do
    post "/"
    expect(last_response).to be_ok
  end
end
