require "spec_helper"

describe "Connection" do
  describe "HTTP&FTP connections" do
    before do
      DataFactory.stub(:http_connection).and_return(:http_connection)
      DataFactory.stub(:ftp_connection).and_return(:ftp_connection)
    end

    it "should return a http_connection" do
      DataFactory.configure do |config|
        config.http = true
      end
      expect(DataFactory.document).to eq(:http_connection)
    end

    it "should return a http_connection" do
      DataFactory.configure do |config|
        config.ftp = true
      end
      expect(DataFactory.document).to eq(:ftp_connection)
    end

    it "should build the http url" do
       DataFactory.configure do |config|
        config.password = "my_password"
       end
      channel_name = "deportes.futbol.colombia.equipos"
      date = Time.now.strftime("%Y%m%d")
      time =  Time.now.strftime("%H%M%S")
      attrs = { canal: channel_name, desde: date, hora: time}
      expect(DataFactory.http_url(attrs).to_s).to eq("http://www.datafactory.ws/clientes/xml/index.php?canal=#{channel_name}&desde=#{date}&hora=#{time}&ppaass=my_password")
    end
  end

  describe "http_connection" do
    it "should return Hpricot::XML" do
       DataFactory.configure do |config|
        config.password = "Golazzos"
        config.http = true
       end
       attrs = {canal: "deportes.futbol.colombia.equipos"}
       expect(DataFactory.document(attrs)).to be_an_instance_of(Nokogiri::XML::Document)
    end
  end
end
