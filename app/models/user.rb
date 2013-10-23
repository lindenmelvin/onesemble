class User < ActiveRecord::Base
  
  has_attached_file :avatar,
    :styles => {
      :thumbnail => '100x101>',
      :regular => '560x568>'
    },
    :storage => :s3,
    :s3_credentials => {
      :bucket => ENV['AWS_BUCKET'],
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    },
    :path => ":filename.:extension"

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
