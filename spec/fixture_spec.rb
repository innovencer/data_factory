require 'spec_helper'

describe 'DataFactory::Fixture' do
  context :champions do
    before :each do
      DataFactory::Fixture.channel_name = "deportes.futbol.champions.fixture.xml"
      VCR.use_cassette 'champions_fixture' do
        @matches = DataFactory::Fixture.load_matches
      end
    end

    it "Loads a list of matches" do
      expect(@matches).to be_instance_of(Array)
    end

    it "Loads a list of matches" do
      expect(@matches.first).to be_instance_of(DataFactory::Match)
    end

    it "Loads a matches list and the first match has an id 240289" do
      expect(@matches.first.id).to eq(240289)
    end

    it "Loads a match with a local team with id 1370" do
      expect(@matches.first.local.id).to eq(1370)
    end
  end

  context 'Eliminatorias' do
    before :each do
      DataFactory::Fixture.channel_name = "deportes.futbol.eliminatorias.fixture.xml"
      VCR.use_cassette 'eliminatorias_fixture' do
        @fixture = DataFactory::Fixture.fetch_all
      end
    end

    it 'The match of Colombia vs Ecuador score is 3-1' do
      matches = @fixture.matches
      match = matches.find{|m| m.id == 2381832}
      expect(match.goles_local).to eq 3
      expect(match.goles_visitante).to eq 1
    end
  end
end

