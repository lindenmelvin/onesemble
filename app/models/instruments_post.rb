class InstrumentsPost < ActiveRecord::Base
  belongs_to :instrument
  belongs_to :post
end