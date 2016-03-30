require "spec_helper"

describe "Connection" do
  describe "http_connection" do
    it "should return Hpricot::XML" do
      VCR.use_cassette 'colombia_teams' do
        attrs = {canal: "deportes.futbol.colombia.equipos"}
        expect(DataFactory.document(attrs)).to be_an_instance_of(Nokogiri::XML::Document)
      end
    end
  end
end
