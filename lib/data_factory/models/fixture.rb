module DataFactory
  class Fixture < Calendar

    self.channel_type = "fixture"

    private

    def self.load_matches
      matches = source_document.xpath("//partido").map do |match|
        Match.new({
          id: match[:id],
          local: load_team(match.at("local")),
          visitante: load_team(match.at("visitante")),
          hora: match[:hora],
          fecha: match[:fecha],
          lugar_ciudad: match["lugarCiudad"],
          nombre_estadio: match["nombreEstadio"],
          estado: match.at("estado").text,
          goles_local: match.at("goleslocal").text,
          goles_visitante: match.at("golesvisitante").text,
          arbitro: match.at("arbitro").to_h,
          medios: (match.at("medios")/"medio").map{|x| x[:nombre]}
        })
      end
      matches.reject{ |match| match.local.id.blank? || match.visitante.id.blank? }
    end
  end
end

