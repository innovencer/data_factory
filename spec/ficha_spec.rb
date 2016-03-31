require 'spec_helper'

describe 'DataFactory::Ficha' do
  context 'On an already played match' do
    let(:ficha){ DataFactory::Ficha.new torneo: 'eliminatorias', id_partido: 2381832 }

    before :each do
      VCR.use_cassette 'ficha_2381832' do
        @match = ficha.match
      end
    end

    it 'has the correct channel' do
      expect(ficha.channel).to eq 'deportes.futbol.eliminatorias.ficha.2381832'
    end

    it 'has a tournament with name Eliminatorias' do
      expect(@match.id_torneo).to eq 3759
    end

    it 'Sets the teams' do
      expect(@match.id_local).to eq 168
      expect(@match.id_visitante).to eq 169
    end

    it 'Sets the goals' do
      expect(@match.goles_local).to eq 3
      expect(@match.goles_visitante).to eq 1
    end

    it 'Sets the id_estado' do
      expect(@match.id_estado).to eq 2
    end

    it 'Sets the start date' do
      expect(@match.start_time).to eq ActiveSupport::TimeZone["Bogota"].parse("20160329 15:30")
    end
  end
end
