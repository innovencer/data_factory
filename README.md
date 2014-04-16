# DataFactory

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'data_factory'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install data_factory

## Usage

Getting the list of Filenames of leagues adquired by Golazzos that contains the team info:

```ruby
DataFactory::LEAGUES #=> ["deportes.futbol.champions.equipos.xml", "deportes.futbol.colombia.equipos.xml", "deportes.futbol.espana.equipos.xml", "deportes.futbol.libertadores.equipos.xml", "deportes.futbol.mexico.equipos.xml", "deportes.futbol.mundial.equipos.xml", "deportes.futbol.peru.equipos.xml", "deportes.futbol.premierleague.equipos.xml"]
```

Extracting the info from a league

```ruby
document_path = "deportes.futbol.champions.equipos.xml"
DataFactory::Team.source_file_name = document_path
DataFactory::Team.fetch_all #=>  [#<DataFactory::Team:0x007fb0e1346cc0 @allowed_writer_methods=#<Set: {"id=", "name=", "complete_name=", "foundation_date=", "country_name=", "nickname1=", "nickname2=", "national_team="}>, @id=1357, @name="Ajax", @complete_name="Amsterdamsche Football Club Ajax", @foundation_date="", @country_name="Holanda", @nickname1="", @nickname2="", @national_team=nil>]

# For extract National Teams
document_path = "deportes.futbol.mundial.equipos.xml"
DataFactory::Team.source_file_name = document_path
DataFactory::Team.fetch_all(national_team: true) #=> [#<DataFactory::Team:0x007fb0e13ec3f0 @allowed_writer_methods=#<Set: {"id=", "name=", "complete_name=", "foundation_date=", "country_name=", "nickname1=", "nickname2=", "national_team="}>, @id=274, @name="Alemania", @complete_name="German Football Association", @foundation_date="", @country_name="Alemania", @nickname1="", @nickname2="", @national_team=true>]
```



## Contributing

Make sure to add tests for it. This is important so It doesn't break it in a future version unintentionally.
Run the tests with:

```
bundle rake spec
```

1. Create your feature branch (`git checkout -b my-new-feature`)
1. Commit your changes (`git commit -am 'Added some feature'`)
1. Push to the branch (`git push origin my-new-feature`)
1. Create new Pull Request
