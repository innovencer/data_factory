require "spec_helper"

describe "Base" do
  it "should return a list of name of leages" do
    DataFactory::LEAGUES.should include "deportes.futbol.champions.equipos.xml"
  end

  it "should set source file name" do
    DataFactory::Team.league_name = "champions"
    DataFactory::Team.class_variable_get(:@@league_name).should == "champions"

    DataFactory::Team.league_name = "mexico"
    DataFactory::Team.class_variable_get(:@@league_name).should == "mexico"
  end

  it "should get the source document in order to extract the info from files" do
    DataFactory.configure do |config|
    end

    DataFactory::Team.league_name = "champions"
    VCR.use_cassette 'champions_teams' do
      DataFactory::Team.source_document.should be_an_instance_of Nokogiri::XML::Document
    end
  end
end
