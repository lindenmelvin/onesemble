class Recommendation < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible :user_id, :subject, :body, :recommender_id
end