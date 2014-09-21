module DataFactory
  class Match < BaseModel
    attribute :id, Integer
    attribute :local, Team
    attribute :visitante, Team
    attribute :fecha, DateTime
    attribute :hora, String
    attribute :lugar_ciudad, String
    attribute :nombre_estadio, String
    attribute :medios, Array[String]
  end
end
