class Book < ApplicationRecord
  has_one_attached :cover
  has_many :notes
end
