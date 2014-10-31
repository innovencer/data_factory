module DataFactory
  class Incidence
    include Virtus.value_object
    attribute :id, String
    attribute :orden, String
    attribute :tipo, String
    attribute :sub_tipo, String
    attribute :minuto, String
    attribute :tiempo, String
    attribute :jugador, Hash
    attribute :team_id, Integer
  end

  class Ficha < BaseModel
    include Virtus.value_object

    self.channel_type = "ficha"
    attribute :tournament, Tournament
    attribute :match, Match
    attribute :incidences, Array[Incidence]

    def self.fecth
      incidences = []
      source_document.xpath("//incidencia").each do |x|
        attrs ={
          id: x[:id],
          orden: x[:orden],
          tipo: x[:tipo],
          sub_tipo: x[:sub_tipo],
          tiempo: x.at("tiempo").text,
          minuto: x.at("minuto").text,
          team_id: x.at("key")[:id],

        }
        incidences << Incidence.new(attrs)
      end
      self.new(incidences: incidences)
    end
  end
end
