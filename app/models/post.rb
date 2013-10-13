class Post < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :instrument
  belongs_to :genre
  
  attr_accessible :subject, :body, :user_id, :instrument_id, :genre_id
  
end