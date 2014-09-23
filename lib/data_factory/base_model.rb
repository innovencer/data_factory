module DataFactory
  class BaseModel
    include Virtus.model

    def self.all
      raise "self.all method should be override by child class"
    end

    protected

    def self.channel_name
      self.class_variable_get(:@@channel_name) rescue nil
    end

    def self.league_name=(league_name)
      self.class_variable_set(:@@league_name, league_name)
    end

    def self.channel_name=(channel_name)
      self.class_variable_set(:@@channel_name, channel_name)
    end

    def self.channel_type=(channel_type)
      self.class_variable_set(:@@channel_type, channel_type)
    end

    def self.source_document
      attrs = { canal: self.build_channel }
      DataFactory.document(attrs)
    end

    private

    def self.build_channel
      return self.channel_name if self.channel_name
      channel_type = self.class_variable_get(:@@channel_type)
      league_name = self.class_variable_get(:@@league_name)
      "deportes.#{DataFactory.configuration.sport}.#{league_name}.#{channel_type}"
    end
  end
end
