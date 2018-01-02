class List < ApplicationRecord
  default_scope { order(created_at: :desc) }
  belongs_to :collection
  has_many :tasks, dependent: :destroy
  paginates_per 50
end
