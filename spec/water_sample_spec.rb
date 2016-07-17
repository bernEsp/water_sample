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
end
