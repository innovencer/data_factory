module DataFactory
  class Partido
    include Virtus.value_object

    attribute :id, Integer
    attribute :id_torneo, Integer
    attribute :id_local, Integer
    attribute :id_visitante, Integer
    attribute :id_estado, Integer
    attribute :goles_local, Integer
    attribute :goles_visitante, Integer
    attribute :fecha, String
    attribute :hora, String

    def start_time
      ActiveSupport::TimeZone["Buenos Aires"].parse("#{fecha} #{hora}")
    end
  end
end
