module DataFactory
  class Tournament
    include Virtus.value_object

    attribute :id, Integer
    attribute :name, String
  end
end
