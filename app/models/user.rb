class User < ActiveRecord::Base
  
  has_attached_file :avatar,
    :bucket => 'onesemble',
    :s3_permissions => :private,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :storage => :s3,
    :path => ":class/:id_partition/:style/:filename",
    :url => ":class/system/:hash.:extension"

  attr_accessor :avatar_file_name
  has_many :posts
  has_many :ratings
  has_many :recommendations
  belongs_to :state
  belongs_to :city
  has_many :contracts_users, dependent: :destroy
  has_many :contracts, through: :contracts_users, dependent: :destroy
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me, :state_id, :city_id, :avatar
end
