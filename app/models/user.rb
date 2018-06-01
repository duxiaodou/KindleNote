class User < ApplicationRecord
  rolify strict: true
  resourcify 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one_attached :clipping
  has_one_attached :avatar

  has_many :access_tokens
  has_many :notes

  has_and_belongs_to_many :roles, :join_table => :users_roles


  after_create :assign_default_role

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end
end
