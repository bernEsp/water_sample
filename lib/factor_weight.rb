class FactorWeight
  attr_accessor :chloroform_weight, :bromoform_weight, :bromodichloromethane_weight, :dibromichloromethane_weight, :id

  def initialize(chloroform_weight: nil, bromoform_weight: nil, bromodichloromethane_weight: nil, dibromichloromethane_weight: nil, id: nil)
    @id = id
    @chloroform_weight = chloroform_weight  
    @bromoform_weight =  bromoform_weight 
    @bromodichloromethane_weight = bromodichloromethane_weight 
    @dibromichloromethane_weight = dibromichloromethane_weight
  end
end
