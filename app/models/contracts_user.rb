class ContractsUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :contract
end