module DataFactory
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  class Configuration
    attr_reader :channels
    attr_accessor :leagues, :url, :password

    def initialize
      @channels = %w(fixture calendario posiciones goleadores ficha plantelxcampeonato)
      @url = 'http://feed.datafactory.la'
      @password = '60l4Zz05'
    end
  end
end
