require 'active_support'
require "active_support/core_ext"
require "virtus"
require "nokogiri"

module DataFactory
  autoload :Ficha, "data_factory/models/ficha"
  autoload :Partido, "data_factory/models/partido"
end
