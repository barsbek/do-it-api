class Collection < ApplicationRecord
  has_many :lists, -> { order(position: :asc) }, dependent: :destroy
  acts_as_list scope: :user, add_new_at: :top

  validates_presence_of :title
  validates_datetime :finish_at
  
  paginates_per 15
end
