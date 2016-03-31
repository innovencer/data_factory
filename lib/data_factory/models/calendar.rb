module DataFactory
  class Calendar < BaseModel
    include Virtus.value_object

    attribute :tournament, Tournament
    attribute :matches, Array[Match]

    self.channel_type = "calendario"
    def self.fetch_all
      matches = []
      source_document.xpath("//campeonato").first[:id]
      tournament = load_tournament
      matches = load_matches

      self.new(tournament: tournament, matches: matches)
    end

    private

    def self.load_matches
      matches = []
      source_document.xpath("//partido").each do |match|
        attrs = {
          id: match[:id],
          local: load_team(match.at("local")),
          visitante: load_team(match.at("visitante")),
          hora: match[:hora],
          fecha: match[:fecha],
          lugar_ciudad: match["lugarCiudad"],
          nombre_estadio: match["nombreEstadio"],
          medios: (match.at("medios")/"medio").map{|x| x[:nombre]}
        }
        matches << Match.new(attrs)
      end
      matches
    end

    def self.load_team(document)
      Team.new(
        id: document[:id],
        name: document.text
      )
    end

    def self.load_tournament
      Tournament.new(id: source_document.xpath("//campeonato").first[:id], name: source_document.xpath("//campeonato").text)
    end
  end
end
