class List < ApplicationRecord
  belongs_to :user
  belongs_to :collection
  acts_as_list scope: :collection, add_new_at: :top
  has_many :tasks, -> { order(position: :asc) }, dependent: :destroy

  paginates_per 50
end
