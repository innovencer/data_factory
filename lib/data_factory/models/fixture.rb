module DataFactory
  class Fixture
    def initialize(tournament)
      @tournament = tournament
    end

    def load_matches
      matches = source_document.xpath("//partido").map do |match|
        Match.new({
          id: match[:id],
          status_id: match.at("estado")[:id].to_i,
          local_score: match.at("goleslocal").text,
          visitant_score: match.at("golesvisitante").text,
          date: match[:fecha], time: match[:hora],
          tournament: load_tournament(source_document.at("campeonato")),
          local_team: load_team(match.at("local")),
          visitant_team: load_team(match.at("visitante")),
        })
      end
      matches.reject{ |match| match.local_team.id.blank? || match.visitant_team.id.blank? }
    end

    def load_tournament(document)
      Tournament.new id: document[:id], name: document.text
    end

    def load_team(document)
      Team.new id: document[:id], name: document.text, initials: document[:sigla]
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
