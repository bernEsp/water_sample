require './lib/client/mysql_adapter'
require './lib/factor_weight'

class WaterSample 

  attr_accessor :id, :site, :chloroform, :bromoform, :bromodichloromethane, :dibromichloromethane, :factor_weights

  def self.find(sample_id)
    sample_id = sample_id.to_i 
    result = mysql_client.query("SELECT * FROM water_samples WHERE id = #{sample_id}")
    map_result(result).first
  end

  def initialize(water_sample_values = {})
    @id   = water_sample_values.fetch(:id, nil)
    @site = water_sample_values.fetch(:site, nil)
    @chloroform = water_sample_values.fetch(:chloroform, nil)
    @bromoform = water_sample_values.fetch(:bromoform, nil)
    @bromodichloromethane = water_sample_values.fetch(:bromodichloromethane, nil)
    @dibromichloromethane = water_sample_values.fetch(:dibromichloromethane, nil)
    @factor_weights = []
  end

  def to_hash(include_factors = false)
    result = {} 
    instance_variables.each do |name|
      name = name.to_s.gsub('@','')
      result[name.to_sym] = self.send(name.to_sym)  unless name == 'factor_weights'
    end
    if include_factors
      factors_hash = {}
      factors.each_with_index do |v,i| 
        factors_hash["factor_#{i}".to_sym] = v
      end
      result.merge!(factors_hash)
    end
    result
  end

  def factor(factor_weight_id)
    factor_weight = factor_weight(factor_weight_id)
    calculate_factor(factor_weight)
  end

  private
    def self.map_result(sql_result)
      sql_result.collect {|row| WaterSample.new(row) }
    end

    def self.mysql_client
      Client::MysqlAdapter.new(database: 'factor_hw', symbolize_keys: true)
    end

    def factor_weight(id)
      factor_weight = WaterSample.mysql_client.query("SELECT * FROM factor_weights WHERE id = #{id}").first
      map_factor_weight( factor_weight )
    end

    def factors
      factor_weights_result = WaterSample.mysql_client.query("SELECT * FROM factor_weights")
      self.factor_weights = []
      factor_weights_result.each { |factor_weight| map_factor_weight(factor_weight) }
      factor_weights.map{|factor_weight| calculate_factor(factor_weight) }
    end

    def calculate_factor(factor_weight)
      [:chloroform, :bromoform, :bromodichloromethane, :dibromichloromethane].inject(0) do |sum, contaminant_name|
        sum + (self.send(contaminant_name) * factor_weight.send( (contaminant_name.to_s + '_weight').to_sym )  )
      end
    end

    def map_factor_weight(factor_weight_sql) 
      factor_weight = FactorWeight.new
      factor_weight_sql.each do |k, v|
        factor_weight.send(k.to_s + '=',v)
      end
      factor_weights << factor_weight
      factor_weight
    end

end
