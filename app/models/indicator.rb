class Indicator < ApplicationRecord
  validates :signaled_at, presence: true
end
