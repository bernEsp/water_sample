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


#### stable-with-activerecord Branch

This branch contains the active record implementation

