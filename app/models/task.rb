class Task < ApplicationRecord
  default_scope { order(:order, :created_at) }
  
  belongs_to :list
  belongs_to :user

  validates_presence_of :title
end
