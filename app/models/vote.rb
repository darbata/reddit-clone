class Vote < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validate :value, inclusion: { in: [-1, 1] }
end
