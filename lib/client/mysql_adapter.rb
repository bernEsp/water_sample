require 'mysql2'
module Client
  class MysqlAdapter
    attr_reader :symbolize_keys

    def initialize(symbolize_keys: false, host:'localhost', username: 'root', password: '', database: '')
       @symbolize_keys = symbolize_keys
       @client = Mysql2::Client.new(host: host, username: username, password: password, database: database)
    end

    def query(query_string)
      @client.query(query_string, symbolize_keys: symbolize_keys)
    end
  end
end
