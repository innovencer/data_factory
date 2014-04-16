require "active_support/core_ext"
require "virtus"
require "hpricot"
require "data_factory/base_model"

module DataFactory
  autoload :Team, "data_factory/models/team"
  autoload :Tournament, "data_factory/models/tournament"

  LEAGUES = Dir.entries(File.expand_path("../data_factory/data", __FILE__),).reject{|entry| entry =~ /^\.{1,2}$/}
end
