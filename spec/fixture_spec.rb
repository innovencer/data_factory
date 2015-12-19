require 'spec_helper'

describe 'DataFactory::Fixture' do
  before :each do
    DataFactory::Fixture.channel_name = "deportes.futbol.champions.fixture.xml"
    DataFactory::Fixture.stub(:source_document).and_return Nokogiri::XML.parse(File.read("./spec/fixtures/champions.fixture"))
  end

  it "Loads a list of matches" do
    expect(DataFactory::Fixture.load_matches).to be_instance_of(Array)
  end

  it "Loads a list of matches" do
    expect(DataFactory::Fixture.load_matches.first).to be_instance_of(DataFactory::Match)
  end

  it "Loads a matches list and the first match has an id 240289" do
    expect(DataFactory::Fixture.load_matches.first.id).to eq(240289)
  end

  it "Loads a match with a local team with id 1370" do
    expect(DataFactory::Fixture.load_matches.first.local.id).to eq(1370)
  end

  it "Ignores a match with an id of 240406" do
    expect(DataFactory::Fixture.load_matches.map(&:id)).to_not include(240406)
  end
end

