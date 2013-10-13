class Specialty < ActiveRecord::Base
  attr_accessible :name
  
  has_many :specialties_posts
  has_many :posts, :through => :specialties_posts
end