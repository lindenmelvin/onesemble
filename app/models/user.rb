class User < ActiveRecord::Base
  
  has_many :posts
  has_many :ratings
  has_many :recommendations
  belongs_to :state
  belongs_to :city
  has_many :contracts_users, dependent: :destroy
  has_many :contracts, through: :contracts_users, dependent: :destroy
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me, :state_id, :city_id
end
