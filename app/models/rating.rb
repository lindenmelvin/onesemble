class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :contract
  
  attr_accessible :user_id, :rater_id, :score
end