class Visa < ApplicationRecord
  belongs_to :visa_category
  has_many :cases
  has_many :comments, as: :commentable
end
