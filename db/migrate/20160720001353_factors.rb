class Factors < ActiveRecord::Migration
  def change
    create_table :factors do |t|
      t.integer :water_sample_id
      t.integer :factor_weight_id
    end
  end
end
