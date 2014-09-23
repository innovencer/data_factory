module DataFactory
  class Tournament < BaseModel
    attribute :id, Integer
    attribute :name, String

    def self.fetch
      document = source_document.xpath("//plantelEquipo")
      attrs = {
        id: document.at("campeonatoNombreAlternativo")[:id],
        name: document.at("campeonatoNombreAlternativo").text
      }

      self.new(attrs)
    end
  end
end
