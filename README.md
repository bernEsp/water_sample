## Water Sample APP

This application maps water sample data to an object and associates with factor
weight object.

#### Public Methods

This app exposes

Class

  * find # Interface to get an specific water sample object with the ID and
  return the instance if exists

Intance
  * to_hash  #  returns a hash with water sample attributes
  * to_hash(true) # returns a hash that includes factors linear combination
  * factor(factor_weight_id) # computes the factor linear combination for the
    given factor weight id


#### Master Branch

Contains a pure ruby app that connects to your database read data from it and
map to water_sample and factor weight objects

#### Run locally
Requirements
   * mysql
   * ruby 2.3.1
   * factor_hw database
   * localhost, root and empty password for mysql

  1. bundle install
  2. bundle exec irb
  3. bundle exec rspec
  4. Run the appplication
  ```ruby
    require './lib/water_sample'
    # Find water sample 
    w = WaterSample.find(1)
    w.factor(2)
    w.to_hash
    w.to_hash(true)

    # get an unexiting water sample
    w2 = WaterSample.find(40)
    # all methods fail because you are not going to have water sample instance
  ```
  



=======================================================================
#### stable-with-activerecord Branch

This branch contains the active record implementation

