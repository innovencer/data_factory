$: << File.dirname(__FILE__)
ENV['RACK_ENV'] = "test"

require 'bundler/setup'
require "rspec/mocks"
Dir["./lib/*.rb"].each {|file| require file }
Dir["./spec/models/*.rb"].each {|file| require file }

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.syntax = :should
  end
end
