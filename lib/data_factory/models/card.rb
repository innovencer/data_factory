module DataFactory
  class Card
    include Virtus.value_object

    attribute :id, Integer
    attribute :tournament, String

    def match
      Match.new({
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

    private

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
