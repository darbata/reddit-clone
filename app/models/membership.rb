class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :community

  # TODO: implement role updating
  # validates :role, presence: true, inclusion: { in: %w(member moderator admin) }
end
