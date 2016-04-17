module DataFactory
  class Fixture
    def initialize(tournament)
      @tournament = tournament
    end

    def load_matches
      matches = source_document.xpath("//partido").map do |match|
        Match.new({
          id: match[:id],
          local_team: load_team(match.at("local")),
          visitant_team: load_team(match.at("visitante")),
          hora: match[:hora],
          fecha: match[:fecha],
          lugar_ciudad: match["lugarCiudad"],
          nombre_estadio: match["nombreEstadio"],
          status_id: match.at("estado")[:id].to_i,
          local_score: match.at("goleslocal").text,
          visitant_score: match.at("golesvisitante").text,
          arbitro: match.at("arbitro").to_h,
          medios: (match.at("medios")/"medio").map{|x| x[:nombre]}
        })
      end
      matches.reject{ |match| match.local_team.id.blank? || match.visitant_team.id.blank? }
    end

    def load_team(document)
      Team.new(id: document[:id], name: document.text)
    end

    def source_document
      attrs = { canal: channel }
      DataFactory.document(attrs)
    end

    def channel
      "deportes.futbol.#{@tournament}.fixture.xml"
    end
  end
end
