class Post < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :city
  belongs_to :state
  has_many :instruments_posts, :dependent => :destroy
  has_many :instruments, :through => :instruments_posts
  has_many :genres_posts, :dependent => :destroy
  has_many :genres, :through => :genres_posts
  has_many :specialties_posts, :dependent => :destroy
  has_many :specialties, :through => :specialties_posts
  
  attr_accessible :subject, :body, :user_id, :state_id, :city_id, :rate, :hourly, :type
  
end