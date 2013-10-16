ENV['RACK_ENV'] = 'test'

require "./game.rb"
require "rspec"
require "rack/test"
require 'sinatra/sessionography'

RSpec.configure do |config|
  config.color_enabled = true
end
