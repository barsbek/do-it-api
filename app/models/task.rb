class Task < ApplicationRecord
  belongs_to :user
  belongs_to :list
  acts_as_list scope: :list

  validates_presence_of :title
end
