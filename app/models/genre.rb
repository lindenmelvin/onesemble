class Genre < ActiveRecord::Base
  attr_accessible :name
  
  has_many :genres_posts
  has_many :posts, :through => :genres_posts
end