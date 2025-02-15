class Community < ApplicationRecord
  belongs_to :creator, class_name: "User"

  has_many :posts, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
