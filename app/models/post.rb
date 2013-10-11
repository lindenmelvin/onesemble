class Post < ActiveRecord::Base
  
  belongs_to :user
  
  attr_accessible :subject, :body, :user_id
  
end