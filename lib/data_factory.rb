require 'active_support'
require 'active_support/core_ext'
require 'virtus'
require 'nokogiri'
require 'typhoeus'
require 'data_factory/configuration'

module DataFactory
  autoload :Connection, 'data_factory/connection'
  autoload :Event, 'data_factory/models/event'
  autoload :Card, 'data_factory/models/card'
  autoload :Fixture, 'data_factory/models/fixture'
  autoload :Team, 'data_factory/models/team'
  autoload :Match, 'data_factory/models/match'
  autoload :Tournament, 'data_factory/models/tournament'

  extend Connection
end
