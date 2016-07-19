require './lib/factor_weight'
describe 'FactorWeight' do
  subject{ FactorWeight.new }

  it 'should id method' do
    expect(subject).to respond_to(:id)
  end
  
  it 'should chloroform_weight method' do
    expect(subject).to respond_to(:chloroform_weight)
  end

  it 'respond to bromoform_weight method' do
    expect(subject).to respond_to(:bromoform_weight)
  end

  it 'respond to bromodichloromethane_weight method' do
    expect(subject).to respond_to(:bromodichloromethane_weight)
  end

  it 'respond to dibromichloromethane_weight method' do
    expect(subject).to respond_to(:dibromichloromethane_weight)
  end

  it 'should id set method' do
    expect(subject).to respond_to(:id=)
  end

  it 'should chloroform_weight set method' do
    expect(subject).to respond_to(:chloroform_weight=)
  end

  it 'respond to bromoform_weight set method' do
    expect(subject).to respond_to(:bromoform_weight=)
  end

  it 'respond to bromodichloromethane_weight set method' do
    expect(subject).to respond_to(:bromodichloromethane_weight=)
  end

  it 'respond to dibromichloromethane_weight set method' do
    expect(subject).to respond_to(:dibromichloromethane_weight=)
  end



end
