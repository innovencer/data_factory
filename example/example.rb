DataFactory.configure do |config|
   config.password = "Golazzos"
   config.http = true
end
DataFactory::Team.league_name = "champions"
all = DataFactory::Team.fetch_all
