$: << File.dirname(__FILE__)
ENV['RACK_ENV'] = "test"

require 'bundler/setup'
Dir["./lib/*.rb"].each {|file| require file }
Dir["./spec/models/*.rb"].each {|file| require file }
