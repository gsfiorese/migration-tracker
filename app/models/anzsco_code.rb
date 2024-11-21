class AnzscoCode < ApplicationRecord
  validates :anzsco_code, presence: true, numericality: { only_integer: true }
  validates :occupation, presence: true
  validates :description, presence: true
end
