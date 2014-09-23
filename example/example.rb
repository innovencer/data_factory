DataFactory.configure do |config|
   config.password = "Golazzos"
   config.http = true
end
DataFactory::Team.league_name = "espana"
DataFactory::Team.fetch_all

DataFactory::Calendar.league_name = "espana"
DataFactory::Calendar.fetch_all
