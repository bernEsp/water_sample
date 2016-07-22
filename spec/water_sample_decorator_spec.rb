require './lib/water_sample'
require './lib/water_sample_decorator'

describe 'WaterSampleDecorator' do
  describe 'hashify' do
    let(:water_sample) { WaterSample.find(2) }
    let(:decorator) { WaterSampleDecorator.new( water_sample: water_sample ) }
    let(:decorator_wfactors) { WaterSampleDecorator.new( water_sample: water_sample, include_factors: true ) }
    let(:hash_water_sample) do
      {
        id: 2,
        site: 'North Hollywood Pump Station (well blend)',
        chloroform: 0.00291,
        bromoform: 0.00487,
        bromodichloromethane: 0.00547,
        dibromichloromethane: 0.0109
      }
    end

    let(:with_factor_weights) do
      hash_water_sample.merge( { :factor_1=>0.024007, :factor_2=>0.02415, :factor_3=>0.021627, :factor_4=>0.02887 } )
    end
    
    it 'return a hash representation of water_sample object' do
      expect(decorator.hashify).to eq(hash_water_sample)
    end

    context 'with factors' do

      it 'should return a hash that includes factors linear composition value' do
        expect(decorator_wfactors.hashify).to eq(with_factor_weights)
      end
    end
  end
end
