class Case < ApplicationRecord
  belongs_to :user
  belongs_to :country
  belongs_to :anzsco_code
  belongs_to :visa
end
