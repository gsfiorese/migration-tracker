# app/models/log.rb
class Log < ApplicationRecord
  belongs_to :user, optional: true
end
