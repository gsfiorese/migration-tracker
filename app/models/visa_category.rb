class VisaCategory < ApplicationRecord
  has_many :visas, dependent: :destroy
end
