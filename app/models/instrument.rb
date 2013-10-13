class Instrument < ActiveRecord::Base
  attr_accessible :name
  
  has_many :instruments_posts
  has_many :posts, :through => :instruments_posts
end