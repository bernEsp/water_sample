class FactorWeight
  attr_accessor :chloroform_weight, :bromoform_weight, :bromodichloromethane_weight, :dibromichloromethane_weight, :id

  def initialize(chloroform_weight: nil, bromoform_weight: nil, bromodichloromethane_weight: nil, dibromichloromethane_weight: nil, id: nil)
    method(__method__).parameters.each do |type, name|
      # this identify the type of parameter: key (keyarguments), req (parameter),
      # opt( hash), rest ( *args )
      next unless type == :key
      value = eval(name.to_s)
      instance_variable_set("@#{name}", value) unless name.nil?
    end
  end

end
