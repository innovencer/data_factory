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

  it 'generate events_messages' do
    expect(card.events_messages).to match_array [
      "Gol de Colombia (Carlos A. Bacca ) | Colombia (1) - Ecuador (0)",
      "Gol de Colombia (Sebastián Pérez ) | Colombia (2) - Ecuador (0)",
      "Gol de Colombia (Carlos A. Bacca ) | Colombia (3) - Ecuador (0)",
      "Michael Arroyo  marca gol de tiro libre para Ecuador | Colombia (3) - Ecuador (1)"
    ]
  end

  describe '#.events_messages' do
    let(:events){[
        DataFactory::Event.new(id: 1, inciid: DataFactory::Event::Goal, minute: 1, time: 'PT', player: 'XXX', key: 168),
        DataFactory::Event.new(id: 2, inciid: DataFactory::Event::HeadGoal, minute: 2, time: 'PT', player: 'XXX', key: 168),
        DataFactory::Event.new(id: 3, inciid: DataFactory::Event::OwnGoal, minute: 3, time: 'PT', player: 'XXX', key: 169),
        DataFactory::Event.new(id: 4, inciid: DataFactory::Event::FreeKickGoal, minute: 4, time: 'ST', player: 'XXX', key: 169),
        DataFactory::Event.new(id: 5, inciid: DataFactory::Event::PenaltyGoal, minute: 5, time: 'ST', player: 'XXX', key: 169),
        DataFactory::Event.new(id: 6, inciid: DataFactory::Event::OwnGoal, minute: 6, time: 'ST', player: 'XXX', key: 168)
      ]}

    it 'generate events messages' do
      card.stub(:events) { events }
      expect(card.events_messages).to match_array [
        "Gol de Colombia (XXX) | Colombia (1) - Ecuador (0)",
        "XXX marca gol de cabeza para Colombia | Colombia (2) - Ecuador (0)",
        "XXX marca autogol a favor de Ecuador | Colombia (2) - Ecuador (1)",
        "XXX marca gol de tiro libre para Ecuador | Colombia (2) - Ecuador (2)",
        "XXX marca gol de penal para Ecuador | Colombia (2) - Ecuador (3)",
        "XXX marca autogol a favor de Colombia | Colombia (3) - Ecuador (3)"
      ]
    end
  end
end
