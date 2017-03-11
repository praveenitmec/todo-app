class Todo < ApplicationRecord
  belongs_to :user
  validates :name,:target_date , uniqueness: true
  validates_with DateValidator
end
