class State < ActiveRecord::Base
  attr_accessible :name, :abbreviation
  
  has_many :cities
  has_many :users
end