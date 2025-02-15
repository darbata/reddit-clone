class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :community

  validates: role, presence: true, inclusion: { in: %w(member moderator admin) }
end
