class Post < ApplicationRecord
  belongs_to :user
  belongs_to :community
  has_many :votes, dependent: :destroy

  def score
    voits.sum(:value)
  end
end
