class Post < ApplicationRecord
  belongs_to :user
  belongs_to :community

  acts_as_votable

  def score
    get_upvotes.size - get_downvotes.size
  end
end
