class AnzscoCode < ApplicationRecord
  validates :anzsco_code, presence: true
  validates :occupation, presence: true
  validates :description, presence: true
end
