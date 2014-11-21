DataFactory.configure do |config|
   config.password = "MyPassword"
   config.http = true
end
DataFactory::Team.league_name = "espana"
DataFactory::Team.fetch_all

DataFactory::Calendar.league_name = "espana"
DataFactory::Calendar.fetch_all

DataFactory::Fixture.league_name = "champions"
DataFactory::Fixture.fetch_all

DataFactory::Ficha.channel_name = "deportes.futbol.mexico.ficha.201320"
DataFactory::Ficha.fetch
