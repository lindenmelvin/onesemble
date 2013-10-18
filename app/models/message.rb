class Message < ActiveRecord::Base
  has_ancestry
  
  belongs_to :receiver, class_name: 'User', foreign_key: :receiver_id
  belongs_to :sender, class_name: 'User', foreign_key: :sender_id
  
  attr_accessible :body, :sender_id, :receiver_id, :parent_id, :read
end