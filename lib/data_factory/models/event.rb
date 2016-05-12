module DataFactory
  class Event
    Goal = 9
    OwnGoal = 10
    HeadGoal = 11
    FreeKickGoal = 12
    PenaltyGoal = 13

    include Virtus.value_object

    attribute :id, Integer
    attribute :inciid, Integer
    attribute :minute, Integer
    attribute :time, String
    attribute :player, String
    attribute :key, Integer
    attribute :match, Match
    attribute :local_score, Integer
    attribute :visitant_score, Integer

    def message
      case inciid
      when Event::Goal
        "#{minute}'' #{time} Gol de #{team.name} (#{player}) #{score_label}"
      when Event::OwnGoal
        "#{minute}'' #{time} #{player} marca autogol a favor de #{team.name} #{score_label}"
      when Event::HeadGoal
        "#{minute}'' #{time} #{player} marca gol de cabeza para #{team.name} #{score_label}"
      when Event::FreeKickGoal
        "#{minute}'' #{time} #{player} marca gol de tiro libre para #{team.name} #{score_label}"
      else
        "#{minute}'' #{time} #{player} marca gol de penal para #{team.name} #{score_label}"
      end
    end

    def team
      match.local_team.id == key ? match.local_team : match.visitant_team
    end

    def score_label
      "| #{match.local_team.name} (#{local_score}) - #{match.visitant_team.name} (#{visitant_score})"
    end

    def self.load_events_from_elements(event_elements, match)
      event_elements = event_elements.sort{ |e1, e2| id(e1) <=> id(e2) }
      events = event_elements.map do |e|
        local_score = partial_local_score(event_elements, e, match)
        visitant_score = partial_visitant_score(event_elements, e, match)
        key = key(e)
        id = id(e)
        inciid = e[:inciid]
        minute = e.xpath('minuto').text
        time = e.xpath('tiempo').text
        player = e.xpath('jugador').text.strip
        Event.new(id: id, inciid: inciid, minute: minute, time: time, match: match, player: player,
                  local_score: local_score, visitant_score: visitant_score, key: key)
      end
    end

    def self.partial_local_score(event_elements, event, match)
      event_elements.select{ |e| id(e) <= id(event) && key(e) == match.local_team.id }.count
    end

    def self.partial_visitant_score(event_elements, event, match)
      event_elements.select{ |e| id(e) <= id(event) && key(e) == match.visitant_team.id }.count
    end

    def self.key(event_element)
      event_element.xpath('key').first[:id].to_i
    end

    def self.id(event_element)
      event_element[:orden].to_i
    end
  end
end
