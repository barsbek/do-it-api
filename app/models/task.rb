class Task < ApplicationRecord
  default_scope { order(:order, :created_at) }
  
  belongs_to :list

  validates_presence_of :title
end
