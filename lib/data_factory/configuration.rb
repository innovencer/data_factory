module DataFactory
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :leagues, :url, :http, :ftp, :password, :sport
    attr_reader :channels

    def initialize
      @channels = %w(fixture calendario posiciones goleadores ficha plantelxcampeonato)
      @http = true
      @url = "http://www.datafactory.ws/clientes/xml/index.php"
      @sport = "futbol"
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
