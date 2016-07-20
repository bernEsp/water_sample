require 'mysql2'
require "sinatra/activerecord"
class Dbconfig < Sinatra::Base
   register Sinatra::ActiveRecordExtension
  set :database, {adapter: 'mysql2', database: 'factor_hw', host: 'localhost', username: 'root', password:''}
end
