require "spec_helper"

describe "Base" do

  it "should return a list of name of leages" do
    DataFactory::LEAGUES.should include "deportes.futbol.champions.equipos.xml"
  end

  it "should set source file name" do
    file_name = "deportes.futbol.champions.equipos.xml"
    DataFactory::Team.source_file_name = file_name
    DataFactory::Team.class_variable_get(:@@source_file_name).should == file_name

    DataFactory::Team.source_file_name = file_name + "2"
    DataFactory::Team.class_variable_get(:@@source_file_name).should == file_name + "2"
  end

  it "should get the source documen in order to extract the  info from files" do
    file_name = "deportes.futbol.champions.equipos.xml"
    DataFactory::Team.source_file_name = file_name
    DataFactory::Team.source_document.should be_an_instance_of Hpricot::Doc
  end
end
