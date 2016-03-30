$: << File.dirname(__FILE__)
ENV['RACK_ENV'] = "test"

require 'bundler/setup'
require 'rspec/mocks'
require 'byebug'
require 'vcr'
Dir["./lib/*.rb"].each {|file| require file }
Dir["./spec/models/*.rb"].each {|file| require file }

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
