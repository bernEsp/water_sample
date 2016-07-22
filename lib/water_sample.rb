require './lib/client/mysql_adapter'
require './lib/factor_weight'
require './lib/water_sample_decorator'

class WaterSample 
  # notice factor_weights attribute acts as has_many relationship
  attr_accessor :id, :site, :chloroform, :bromoform, :bromodichloromethane, :dibromichloromethane, :factor_weights

  # This method find a record in water samples table and create a water_sample
  # object.
  
  def self.find(sample_id)
    sample_id = sample_id.to_i 
    result = mysql_client.query("SELECT * FROM water_samples WHERE id = #{sample_id}")
    map_result(result).first
  end

  # Besides the old sinxtax of parameters this support a hash that contains the
  # sql row
  def initialize(id: nil,site: nil, chloroform: nil,bromoform: nil, bromodichloromethane: nil, dibromichloromethane: nil, factor_weights: [])
    method(__method__).parameters.each do |type, name|
      # this identify the type of parameter: key (keyarguments), req (parameter),
      # opt( hash), rest ( *args )
      next unless type == :key
      value = eval(name.to_s)
      instance_variable_set("@#{name}", value) unless name.nil?
    end
  end

  # this protocol map instance attributes to a hash
  # implements the inclusion of factors which is the linear combination of
  # factor weights and sample attributes, maping as many factors as
  # factor_weights size
  #
  def to_hash(include_factors = false)
    decorates_myself(include_factors)
  end

  # factor computes the linear combination of a factor_weight with water sample
  # attributes
  def factor(factor_weight_id)
    begin
      factor_weight = factor_weight(factor_weight_id)
      calculate_factor(factor_weight)
    rescue
      InvalidFactor.new
    end
  end

  private
    def self.map_result(sql_result)
      sql_result.collect {|row| WaterSample.new(row) }
    end

    def self.mysql_client
      Client::MysqlAdapter.new(database: 'factor_hw', symbolize_keys: true)
    end

    def factor_weight(id) 
      load_factor_weights!
      factor_weights.select{|factor_weight| factor_weight.id == id }.first
    end

    def factors
      load_factor_weights!
      factor_weights.map{|factor_weight| calculate_factor(factor_weight) }
    end

    def load_factor_weights!
      return unless factor_weights.empty?
      factor_weights_result = WaterSample.mysql_client.query("SELECT * FROM factor_weights")
      self.factor_weights = []
      factor_weights_result.each { |factor_weight| map_factor_weight(factor_weight) }
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

    def decorates_myself(include_factors)
      WaterSampleDecorator.new(water_sample: self, include_factors:include_factors).hashify
    end
end
