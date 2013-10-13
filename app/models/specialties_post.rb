class SpecialtiesPost < ActiveRecord::Base
  belongs_to :specialty
  belongs_to :post
end