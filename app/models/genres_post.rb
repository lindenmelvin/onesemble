class GenresPost < ActiveRecord::Base
  belongs_to :genre
  belongs_to :post
end