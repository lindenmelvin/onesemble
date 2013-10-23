class User < ActiveRecord::Base
  
  has_attached_file :avatar,
    styles: {
        thumb: '100x100>',
        square: '200x200#',
        medium: '300x300>'
    },
    :default_url => 'missing.png',
    :s3_protocol => 'https',
    :bucket => 'onesemble',
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :storage => :s3,
    :path => "/:class/:attachment/:id_partition/:style/:filename",
    :url => ":s3_domain_url"

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
