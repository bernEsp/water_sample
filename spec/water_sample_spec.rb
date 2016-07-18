require './lib/water_sample'
describe 'WaterSample' do
  describe 'find' do
    subject(:water_sample) { WaterSample.find(2)}
    it 'should return a water sample instance' do
      expect(water_sample).to be_an_instance_of(WaterSample)
    end

    it 'water sample instace should have expected site value' do
      expect(water_sample.site).to eq('North Hollywood Pump Station (well blend)')
    end

    it 'water sample instace should have expected chloroform value' do
      expect(water_sample.chloroform).to eq(0.00291)
    end

    it 'water sample instace should have expected bromoform value' do
      expect(water_sample.bromoform).to eq(0.00487)
    end

    it 'water sample instace should have expected bromodichloromethane value' do
      expect(water_sample.bromodichloromethane).to eq(0.00547)
    end

    it 'water sample instace should have expected dibromichloromethane value' do
      expect(water_sample.dibromichloromethane).to eq(0.0109)
    end
  end

  describe 'to_hash' do
    subject(:water_sample) { WaterSample.find(2) }
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
     hash_water_sample.merge( {'factor_5':  0.0213, 'factor_6': 0.432, 'factor_9':  0.0321} )
    end

    it 'should respond to to_hash method' do
      expect(water_sample).to respond_to(:to_hash)
    end

    it 'should return a hash of attributes' do
      expect(water_sample.to_hash).to eq(hash_water_sample)
    end
  end
end
