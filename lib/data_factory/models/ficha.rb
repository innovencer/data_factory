module DataFactory
  class Ficha
    include Virtus.value_object

    attribute :torneo, String
    attribute :id_partido, Integer

    def match
      Partido.new({
        id_torneo: document.xpath('//campeonato/@id').text,
        id_local: document.xpath("//equipo[@condicion='local']/@id").text,
        id_visitante: document.xpath("//equipo[@condicion='visitante']/@id").text,
        id_estado: document.xpath('//estadoEvento/@idestado').text,
        goles_local: document.xpath("//equipo[@condicion='local']/@goles").text,
        goles_visitante: document.xpath("//equipo[@condicion='visitante']/@goles").text,
        fecha: document.xpath("//fichapartido/@dia").text,
        hora: document.xpath("//fichapartido/@horario").text
      })
    end

    def channel
      "deportes.futbol.#{torneo}.ficha.#{id_partido}"
    end

    private

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

    def load_team(xpath)
      team_node = document.xpath(xpath).first
      Team.new({
        id: team_node[:id],
        nombre: team_node[:nombre],
        sigla: team_node[:sigla]
      })
    end

    def load_tournament
      node_campeonato = document.xpath('//campeonato').first
      Tournament.new id: node_campeonato[:id], name: node_campeonato.text
    end
  end
end
