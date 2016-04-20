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
  end
end
