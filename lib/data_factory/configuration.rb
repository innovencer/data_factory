module DataFactory
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  class Configuration
    attr_accessor :leagues, :url, :http, :ftp, :password, :sport
    attr_reader :channels

    def initialize
      @channels = %w(fixture calendario posiciones goleadores ficha plantelxcampeonato)
      @http = true
      @url = 'http://feed.datafactory.la'
      @sport = 'futbol'
      @password = 'Golazzos'
    end

    def http=(value)
      @http = value
      @ftp = !value
    end

    def ftp=(value)
      @http = !value
      @ftp = value
    end
  end
end
