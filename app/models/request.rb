class Request < ActiveRecord::Base
  
  attr_accessible :sender_id, :receiver_id, :pending, :accepted
end