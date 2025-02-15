class Community < ApplicationRecord
  belongs_to :creator

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
end
