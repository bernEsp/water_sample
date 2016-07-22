require './lib/invalid_factor'

describe 'InvalidFactor' do
  subject { InvalidFactor.new }

  it 'return 0 as to_i representation' do
    expect(subject.to_i).to eq(0)
  end

  it 'return invalid factor string  as to_s representation' do
    expect(subject.to_s).to eq('This is and invalid factor')
  end
end
