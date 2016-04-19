module DataFactory
  class Fixture
    include Virtus.value_object

    attribute :id, Integer
    attribute :tournament, String

    def initialize(tournament_name)
      @tournament_name = tournament_name
      @tournament = load_tournament
    end

    def load_matches
      matches = source_document.xpath("//partido").map do |match|
        Match.new({
          id: match[:id],
          status_id: match.at("estado")[:id].to_i,
          local_score: match.at("goleslocal").text.to_i,
          visitant_score: match.at("golesvisitante").text.to_i,
          date: match[:fecha], time: match[:hora],
          tournament: @tournament,
          local_team: load_team(match.at("local")),
          visitant_team: load_team(match.at("visitante")),
        })
      end
      matches.reject{ |match| match.local_team.id.blank? || match.visitant_team.id.blank? }
    end

    def channel
      "deportes.futbol.#{@tournament_name}.fixture.xml"
    end

    private

    def load_tournament
      document = source_document.at("campeonato")
      Tournament.new id: document[:id], name: document.text
    end

    def load_team(document)
      Team.new id: document[:id], name: document.text, initials: document[:sigla]
    end

    def source_document
      attrs = { canal: channel }
      @document ||= DataFactory.document(attrs)
    end
  end
end
