module DataFactory
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  class Configuration
    attr_accessor :leagues, :url, :password, :sport
    attr_reader :channels

    def initialize
      @channels = %w(fixture calendario posiciones goleadores ficha plantelxcampeonato)
      @url = 'http://feed.datafactory.la'
      @sport = 'futbol'
      @password = 'Golazzos'
    end
  end
end
