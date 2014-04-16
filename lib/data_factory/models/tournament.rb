module DataFactory
  class Tournament < BaseModel
    attribute :id, Integer
    attribute :name, String

    def self.fetch
      document = (source_document/"plantelEquipo")
      attrs = {
        id: document.at("campeonatoNombreAlternativo")[:id],
        name: document.at("campeonatoNombreAlternativo").inner_html
      }

      self.new(attrs)
    end
  end
end
