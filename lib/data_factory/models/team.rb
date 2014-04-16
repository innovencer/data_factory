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
    attribute :national_team, Boolean

    def self.fetch_all(attrs = {})
      teams = []
      (source_document/"equipo").each do |obj|
        attrs = {
          id: obj[:id],
          name: obj.at("nombre").inner_html,
          complete_name: obj.at("nombreCompleto").inner_html,
          foundation_date: obj.at("fechaFundacion").inner_html,
          country_name: obj["paisNombre"],
          nickname1: obj.at("apodo").inner_html,
          nickname2: obj.at("apodo").inner_html,
          national_team: attrs[:national_team]
        }
        teams << self.new(attrs)
      end
      teams
    end
  end
end
