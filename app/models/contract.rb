class Contract < ActiveRecord::Base
  has_many :contracts_users, dependent: :destroy
  has_many :users, through: :contracts_users
  
  has_many :ratings, dependent: :destroy
  
  attr_accessible :complete
end