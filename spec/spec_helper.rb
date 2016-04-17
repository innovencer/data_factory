$: << File.dirname(__FILE__)
ENV['RACK_ENV'] = "test"

require 'bundler/setup'
require 'rspec/mocks'
require 'byebug'
require 'simplecov'
require 'vcr'
require './lib/data_factory'

SimpleCov.start do
  add_filter '/spec'
end

VCR.configure do |config|
  config.hook_into :typhoeus
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.default_cassette_options = {record: :new_episodes}

  config.before_record do |i|
    i.response.body.force_encoding 'ISO-8859-1'
  end
end

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.syntax = :should
  end
end
