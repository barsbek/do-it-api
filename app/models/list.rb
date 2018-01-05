class List < ApplicationRecord
  belongs_to :collection
  belongs_to :user
  has_many :tasks, -> { order(position: :asc) }, dependent: :destroy

  paginates_per 50
end
