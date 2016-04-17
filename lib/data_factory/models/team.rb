module DataFactory
  class Team
    include Virtus.value_object

    attribute :id, Integer
    attribute :name, String
    attribute :country, String
  end
end
