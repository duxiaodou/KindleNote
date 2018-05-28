class Book < ApplicationRecord
  has_one_attached :cover
  has_many :notes
  paginates_per 6
end
