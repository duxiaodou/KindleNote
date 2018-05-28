class Note < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_one_attached :cover
  has_many :fragments
  paginates_per 5
end
