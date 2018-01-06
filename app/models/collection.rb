class Collection < ApplicationRecord
  has_many :lists, -> { order(position: :asc) }, dependent: :destroy

  validates_presence_of :title
  validates_datetime :finish_at
  
  paginates_per 15
end
