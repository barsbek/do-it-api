class Task < ApplicationRecord
  default_scope { order(created_at: :desc) }
  
  belongs_to :list

  validates_presence_of :title
end
