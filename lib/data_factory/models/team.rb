module DataFactory
  class Team < BaseModel
    include Virtus.value_object
    attribute :id, Integer
    attribute :name, String
    attribute :complete_name, String
    attribute :foundation_date, Date
    attribute :country_name, String
    attribute :nickname1, String
    attribute :nickname2, String
    attribute :initials, String
    attribute :national_team, Boolean

    self.channel_type = "equipos"

    def self.fetch_all(attrs = {})
      teams = []
      source_document.xpath("//equipo").each do |obj|
        attrs = {
          id: obj[:id],
          name: obj.at("nombre").text,
          complete_name: obj.at("nombreCompleto").text,
          foundation_date: obj.at("fechaFundacion").text,
          country_name: obj["paisNombre"],
          nickname1: obj.at("apodo").text,
          nickname2: obj.at("apodo2").text,
          initials: obj.at("sigla").text,
          national_team: attrs[:national_team]
        }
        teams << self.new(attrs)
      end
      teams
    end
  end
end
