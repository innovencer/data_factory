require 'active_support'
require "active_support/core_ext"
require "virtus"
require "nokogiri"
require "data_factory/configuration"
require "data_factory/base_model"

module DataFactory
  autoload :Connection, "data_factory/connection"
  autoload :Calendar, "data_factory/models/calendar"
  autoload :Ficha, "data_factory/models/ficha"
  autoload :Fixture, "data_factory/models/fixture"
  autoload :Match, "data_factory/models/match"
  autoload :Team, "data_factory/models/team"
  autoload :Tournament, "data_factory/models/tournament"

  LEAGUES = Dir.entries(File.expand_path("../data_factory/data", __FILE__),).reject{|entry| entry =~ /^\.{1,2}$/}
  extend Connection
end
