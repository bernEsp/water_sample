require './lib/client/mysql_adapter'
describe 'MysqlAdapter' do
  describe '.new' do
    it 'should return a client connect with default values' do
      expect{Client::MysqlAdapter.new}.not_to raise_error
    end

    it 'should respond to query' do
      expect(Client::MysqlAdapter.new).to respond_to(:query)
    end

  end
end
