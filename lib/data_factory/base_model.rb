module DataFactory
  class BaseModel
    include Virtus.model

    def self.all
      raise "self.all method should be override by child class"
    end

    protected

    def self.source_file_name=(path)
      self.class_variable_set(:@@source_file_name, path)
    end

    def self.league_name=(league_name)
      self.class_variable_set(:@@league_name, league_name)
    end

    def self.channel_name=(channel_name)
      self.class_variable_set(:@@channel_name, channel_name)
    end

    def self.source_document
      DataFactory.document({ canal: self.build_channel })
    end

    private

    def self.build_channel
      channel_name = self.class_variable_get(:@@channel_name)
      league_name = self.class_variable_get(:@@league_name)
      "deportes.#{DataFactory.configuration.sport}.#{league_name}.#{channel_name}"
    end
  end
end
