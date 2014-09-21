module DataFactory
  class BaseModel
    include Virtus.model

    def self.all
      raise "self.all method should be override by child class"
    end

    protected

    def self.start_date
      self.class_variable_get(:@@start_date) rescue nil
    end

    def self.start_date=(start_date)
      self.class_variable_set(:@@start_date, start_date)
    end

    def self.start_time=(start_time)
      self.class_variable_set(:@@start_time, start_time)
    end

    def self.start_time
      self.class_variable_get(:@@start_time) rescue nil
    end

    def self.league_name=(league_name)
      self.class_variable_set(:@@league_name, league_name)
    end

    def self.channel_name=(channel_name)
      self.class_variable_set(:@@channel_name, channel_name)
    end

    def self.source_document
      attrs = { canal: self.build_channel }
      attrs[:desde] = self.start_date if self.start_date
      attrs[:hora] = self.start_time if self.start_time
      DataFactory.document(attrs)
    end

    private

    def self.build_channel
      channel_name = self.class_variable_get(:@@channel_name)
      league_name = self.class_variable_get(:@@league_name)
      "deportes.#{DataFactory.configuration.sport}.#{league_name}.#{channel_name}"
    end
  end
end
