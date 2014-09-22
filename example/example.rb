DataFactory.configure do |config|
   config.password = "Golazzos"
   config.http = true
end
DataFactory::Team.league_name = "champions"
DataFactory::Team.fetch_all

DataFactory::Calendar.league_name = "champions"
DataFactory::Calendar.fetch_all
