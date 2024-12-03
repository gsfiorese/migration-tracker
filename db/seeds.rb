# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create!(
  first_name: "admin",
  email: "admin@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: "admin" # Optional attribute, depending on your User model
)

User.create!(
  first_name: "customer",
  email: "customer@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: "member" # Optional attribute, depending on your User model
)
