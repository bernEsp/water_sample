require './lib/client/mysql_adapter'

class WaterSample 

  attr_accessor :id, :site, :chloroform, :bromoform, :bromodichloromethane, :dibromichloromethane

  def self.find(sample_id)
    sample_id = sample_id.to_i
    client = Client::MysqlAdapter.new(database: 'factor_hw', symbolize_keys: true)
    result = client.query("SELECT * FROM water_samples WHERE id = #{sample_id}")
    map_result(result).first
  end

  def initialize(water_sample_values = {})
    @id   = water_sample_values.fetch(:id, nil)
    @site = water_sample_values.fetch(:site, nil)
    @chloroform = water_sample_values.fetch(:chloroform, nil)
    @bromoform = water_sample_values.fetch(:bromoform, nil)
    @bromodichloromethane = water_sample_values.fetch(:bromodichloromethane, nil)
    @dibromichloromethane = water_sample_values.fetch(:dibromichloromethane, nil)
  end

  def to_hash(include_factors = false)
    result = {}
    instance_variables.each do |name|
      name = name.to_s.gsub('@','')
      result[name.to_sym] =  self.send(name.to_sym) 
    end
    result
  end

  private
    def self.map_result(sql_result)
      sql_result.collect {|row| WaterSample.new(row) }
    end

end
