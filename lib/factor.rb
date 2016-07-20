require './lib/factor_weight'
require './lib/water_sample'

class Factor < ActiveRecord::Base
  establish_connection adapter: 'mysql2', host: 'localhost', username: 'root', password: '', database: 'factor_hw'
  belongs_to :water_sample
  belongs_to :factor_weight
end
