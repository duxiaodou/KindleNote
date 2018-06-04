class Permission < ApplicationRecord
  validates :name, presence: true
  validates :title, presence: true

  has_and_belongs_to_many :roles, :join_table => :permissions_roles
end
