# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160720001353) do

  create_table "factor_weights", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.float "chloroform_weight",           limit: 24
    t.float "bromoform_weight",            limit: 24
    t.float "bromodichloromethane_weight", limit: 24
    t.float "dibromichloromethane_weight", limit: 24
  end

  create_table "factors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "water_sample_id"
    t.integer "factor_weight_id"
  end

  create_table "water_samples", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "site"
    t.float  "chloroform",           limit: 24
    t.float  "bromoform",            limit: 24
    t.float  "bromodichloromethane", limit: 24
    t.float  "dibromichloromethane", limit: 24
  end

end
