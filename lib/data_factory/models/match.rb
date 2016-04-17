module DataFactory
  class Match
    include Virtus.value_object

    attribute :id, Integer
    attribute :status_id, Integer
    attribute :local_score, Integer
    attribute :visitant_score, Integer
    attribute :date, String
    attribute :time, String
    attribute :tournament, Tournament
    attribute :local_team, Team
    attribute :visitant_team, Team

    def start_time
      ActiveSupport::TimeZone["Buenos Aires"].parse("#{date} #{time}")
    end
  end
end
