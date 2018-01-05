class Task < ApplicationRecord
  belongs_to :list
  acts_as_list scope: :list
  
  belongs_to :user

  validates_presence_of :title
end
