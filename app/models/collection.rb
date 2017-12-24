class Collection < ApplicationRecord
  has_many :lists
  validates_presence_of :title
  validates_datetime :finish_at
end
