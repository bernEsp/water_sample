require 'active_record'
require './lib/factor'
require './lib/factor_weight'

class WaterSample  < ActiveRecord::Base
  establish_connection adapter: 'mysql2', host: 'localhost', username: 'root', password: '', database: 'factor_hw'
  include ActiveModel::Serialization

  has_many :factors
  has_many :factor_weights, through: :factors

  # this protocol map instance attributes to a hash
  # implements the inclusion of factors which is the linear combination of
  # factor weights and sample attributes, maping as many factors as
  # factor_weights size
  #
  def to_hash(include_factors = false)
    hash_attributes = attributes
    hash_attributes = factors_hash(hash_attributes) if include_factors
    hash_attributes.symbolize_keys
  end

  # factor computes the linear combination of a factor_weight with water sample
  # attributes
  def factor(factor_weight_id)
    factor_weight = factor_weight(factor_weight_id)
    calculate_factor(factor_weight)
  end

  private

    def factor_weight(id) 
      factor_weights.to_a.select{|factor_weight| factor_weight.id == id }.first
    end

    def factors_hash(hash)
      factor_weights.pluck(:id).sort.inject(hash) do |result, id| 
        result["factor_#{id}"] = factor(id)
        result
      end
    end

    def calculate_factor(factor_weight)
      attributes.except('id','site').sum do |contaminant_name, value|
        (value * factor_weight.send( ("#{contaminant_name}_weight").to_sym )  )
      end
    end

end
