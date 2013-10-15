class Message < ActiveRecord::Base
  has_ancestry
  attr_accessible :body, :sender_id, :receiver_id, :parent_id, :read
end