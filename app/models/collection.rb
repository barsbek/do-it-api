class Collection < ApplicationRecord
  validates_presence_of :title
  validates_datetime :finish_at
end
