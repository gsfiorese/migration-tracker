class Country < ApplicationRecord
  # Ensure that description is a permitted attribute
  validates :name, presence: true
end
