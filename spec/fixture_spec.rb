require 'spec_helper'

describe 'DataFactory::Fixture' do
  context 'Champions' do
    let(:fixture){ DataFactory::Fixture.new 'champions' }

    before :each do
      VCR.use_cassette 'champions_fixture', allow_playback_repeats: true do
        @matches = fixture.load_matches
      end
    end

    it 'Loads a matches list and the first match has an id 240289' do
      expect(@matches.first.id).to eq(240289)
    end

    it "Loads match's teams" do
      expect(@matches.first.local_team.id).to eq 1370
      expect(@matches.first.visitant_team.id).to eq 3294
    end
  end

  context 'Eliminatorias' do
    let(:fixture){ DataFactory::Fixture.new 'eliminatorias' }

    before :each do
      VCR.use_cassette 'eliminatorias_fixture', allow_playback_repeats: true do
        @matches = fixture.load_matches
      end
    end

    it 'The match of Colombia vs Ecuador score is 3-1' do
      match = @matches.find{|m| m.id == 2381832}
      expect(match.local_score).to eq 3
      expect(match.visitant_score).to eq 1
      expect(match.status_id).to eq 2
    end
  end
end
