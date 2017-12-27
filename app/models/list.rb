class List < ApplicationRecord
  default_scope { order(created_at: :desc) }
  belongs_to :collection
  has_many :tasks
  paginates_per 10
end
