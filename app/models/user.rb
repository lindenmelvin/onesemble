class User < ActiveRecord::Base
  
  has_many :posts
  has_many :ratings
  belongs_to :state
  belongs_to :city
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me, :state_id, :city_id
end
