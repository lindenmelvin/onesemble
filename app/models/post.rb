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
  
  attr_accessible :subject, :body, :user_id, :state_id, :city_id, :rate, :hourly,
                  :type, :start_date, :end_date, :all_day
  
  def create_date(date_hash, all_day)
    if date_hash
      if all_day
        return date_hash.strftime("%A %B %d %Y")
      else
        return date_hash.strftime("%A %B %d %Y at %I:%M %p")
      end
    else
      return ''
    end
  end
end