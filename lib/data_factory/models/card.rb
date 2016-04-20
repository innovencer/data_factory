module DataFactory
  class Card
    include Virtus.value_object

    attribute :id, Integer
    attribute :tournament, String

    def events
      @events ||= document.xpath("//incidencia[@tipo='gol']").map{|e| DataFactory::Event.new(
        id: e[:orden], inciid: e[:inciid], minute: e.xpath('minuto').text, time: e.xpath('tiempo').text,
        player: e.xpath('jugador').text, key: e.xpath('key').first[:id])}.sort{ |e1, e2| e1.id <=> e2.id }
    end

    def match
      @match ||= Match.new({
        id: id,
        status_id: document.xpath('//estadoEvento/@idestado').text,
        local_score: document.xpath("//equipo[@condicion='local']/@goles").text,
        visitant_score: document.xpath("//equipo[@condicion='visitante']/@goles").text,
        date: document.xpath("//fichapartido/@dia").text,
        time: document.xpath("//fichapartido/@horario").text,
        tournament: load_tournament,
        local_team: load_team('local'),
        visitant_team: load_team('visitante')
      })
    end

    def events_messages
      @messages ||= events.map{|event| message_for event}
    end

    private

    def local_score_for(event)
      events.select{|e| e.id <= event.id && e.key == match.local_team.id}.count
    end

    def visitant_score_for(event)
      events.select{|e| e.id <= event.id && e.key == match.visitant_team.id}.count
    end

    def event_team(event)
      match.local_team.id == event.key ? match.local_team : match.visitant_team
    end

    def score_label(event)
      "| #{match.local_team.name} (#{local_score_for(event)}) - #{match.visitant_team.name} (#{visitant_score_for(event)})"
    end

    def message_for(event)
      team = event_team event
      player = event.player

      case event.inciid
      when Event::Goal
        "Gol de #{team.name} (#{player}) #{score_label(event)}"
      when Event::OwnGoal
        "#{player} marca autogol a favor de #{team.name} #{score_label(event)}"
      when Event::HeadGoal
        "#{player} marca gol de cabeza para #{team.name} #{score_label(event)}"
      when Event::FreeKickGoal
        "#{player} marca gol de tiro libre para #{team.name} #{score_label(event)}"
      else
        "#{player} marca gol de penal para #{team.name} #{score_label(event)}"
      end
    end

    def load_tournament
      Tournament.new(
        id: document.xpath('//campeonato/@id').text,
        name: document.xpath('//campeonato').text
      )
    end

    def load_team(condition)
      Team.new(
        id: document.xpath("//equipo[@condicion='#{condition}']/@id").text,
        name: document.xpath("//equipo[@condicion='#{condition}']/@nombre").text,
        country: document.xpath("//equipo[@condicion='#{condition}']/@pais").text
      )
    end

    def channel
      "deportes.futbol.#{tournament}.ficha.#{id}"
    end

    def http_url
      uri = URI 'http://feed.datafactory.la'
      attrs = {canal: channel, ppaass: 'Golazzos'}
      URI::HTTP.build({host: uri.host, path: uri.path, query: attrs.to_query})
    end

    def document
      @document ||= Nokogiri::XML.parse response.body
    end

    def response
      Typhoeus.get http_url, accept_encoding: 'gzip'
    end
  end
end
