class WaterSampleDecorator

  def initialize(water_sample:, include_factors: false)
    @water_sample = water_sample
    @include_factors = include_factors
    @decorator = {}
  end

  def hashify
    @water_sample.instance_variables.each do |name|
      name = name.to_s.gsub('@','')
      @decorator[name.to_sym] = @water_sample.send(name.to_sym)  unless name == 'factor_weights'
    end

    if @include_factors
      factors_hash = {}
      @water_sample.send(:factors).each_with_index do |v,i| 
        factors_hash["factor_#{i+1}".to_sym] = v
      end
      @decorator.merge!(factors_hash)
    end
    @decorator
  end


end
