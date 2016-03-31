module DataFactory
  class Equipo
    include Virtus.value_object

    attribute :id, Integer
    attribute :nombre, String
    attribute :nombre_completo, String
    attribute :pais, String
    attribute :sigla, String
  end
end
