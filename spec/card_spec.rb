require 'spec_helper'

describe DataFactory::Card do
  let(:card){ DataFactory::Card.new tournament: 'eliminatorias', id: 2381832 }

  before :each do
    VCR.use_cassette "ficha_#{card.id}" do
      @match = card.match
    end
  end

  it 'has a tournament with name Eliminatorias' do
    expect(@match.tournament.id).to eq 3759
  end

  it 'Sets the teams' do
    expect(@match.local_team.id).to eq 168
    expect(@match.visitant_team.id).to eq 169
  end

  it 'Sets the goals' do
    expect(@match.local_score).to eq 3
    expect(@match.visitant_score).to eq 1
  end

  it 'Sets the id_estado' do
    expect(@match.status_id).to eq 2
  end

  it 'Sets the start date' do
    expect(@match.start_time).to eq ActiveSupport::TimeZone["Bogota"].parse("20160329 15:30")
  end

  describe '#events_messages' do
    it 'generates events_messages' do
      expect(card.events_messages).to match_array [
        "14'' PT Gol de Colombia (Carlos A. Bacca) | Colombia (1) - Ecuador (0)",
        "2'' ST Gol de Colombia (Sebastián Pérez) | Colombia (2) - Ecuador (0)",
        "21'' ST Gol de Colombia (Carlos A. Bacca) | Colombia (3) - Ecuador (0)",
        "44'' ST Michael Arroyo marca gol de tiro libre para Ecuador | Colombia (3) - Ecuador (1)"
      ]
    end
  end
end
