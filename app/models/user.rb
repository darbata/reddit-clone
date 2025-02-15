class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :memberships, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :communities, through: :memberships
  
  has_many :votes, dependent: :destroy

  # Following
  has_many :follower_relationships, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :following_relationships, source: :followed

  acts_as_voter

  validates :username, presence: true, uniqueness: { case_sensitive: false }

  def score
    get_upvotes.size - get_downvotes.size
  end
end
