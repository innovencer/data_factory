module DataFactory
  class Match < BaseModel
    attribute :id, Integer
    attribute :local, Team
    attribute :visitante, Team
    attribute :fecha, String
    attribute :hora, String
    attribute :lugar_ciudad, String
    attribute :nombre_estadio, String
    attribute :medios, Array[String]

    def start_time
      ActiveSupport::TimeZone[time_zone].parse("#{fecha} #{hora}")
    end

    def time_zone
      "Buenos Aires"
    end
  end
end
