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

    def self.source_document
      file_dir = File.join(File.expand_path("../data", __FILE__),  self.class_variable_get(:@@source_file_name))
      Hpricot::XML(File.read(file_dir).force_encoding("ISO-8859-1").encode("utf-8", replace: nil))
    end
  end
end
