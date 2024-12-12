# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


User.find_or_create_by!(email: "admin@gmail.com") do |user|
  user.first_name = "admin"
  user.email = "admin@gmail.com"
  user.password = "123456"
  user.password_confirmation = "123456"
  user.role = "admin" # Optional attribute, depending on your User model
end

User.find_or_create_by!(email: "customer@gmail.com") do |user|
  user.first_name = "customer"
  user.email = "customer@gmail.com"
  user.password = "123456"
  user.password_confirmation = "123456"
  user.role = "member" # Optional attribute, depending on your User model
end

users = []
2000.times do
    email = Faker::Internet.unique.email
  # end while existing_emails.include?(email) # Ensure no duplicates with pre-existing emails

  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: email,
    password: "123456",
    password_confirmation: "123456",
    role: "member"
  )

  users << user
end

countries = Country.all
anzsco_codes = AnzscoCode.all
visas = Visa.all
users = User.all

users.each do |user|
  Case.create!(
    user_id: user.id,
    country_id: countries.ids.sample,
    anzsco_code_id: anzsco_codes.ids.sample,
    visa_id: visas.ids.sample,
    lodgement_date: (lodgement_date = Date.today - rand(75..100)),
    co_contact_date: (co_contact_date = Date.today - rand(40..50)),
    co_response_date: (co_response_date = Date.today - rand(25..40)),
    grant_date: (grant_date = Date.today - rand(1..25)),
    assess_commence: (assess_commence = Date.today - rand(50..75)),
    grant_days: (grant_date - lodgement_date).to_i,
    days_to_co_contact: (co_contact_date - lodgement_date).to_i,
    days_grant_aftr_co_contact: (grant_date - co_contact_date).to_i,
    work_p_claim: rand(0..15),
    total_p: rand(50..130),
    days_aftr_assess: rand(1..15),
    case_status: ["Application Received", "In Progress", "Further Information Requested", "Awaiting Outcome", "Granted", "Finalised", "Refused", "Expired", "Cancelled/Withdrawn"].sample,
    agency: ["Yes", "No"].sample,
    on_shore: [true, false].sample,
    employment_verification: [true, false].sample,
    sponsor_state: ["NSW", "VIC", "QLD", "SA", "WA", "TAS", "NT", "ACT", "None"].sample,
    documents: ["Passport", "Birth Certificate", "Skills Assessment", "Academic Qualifications", "Resume", "Paysilps", "English Profficiency Score", "Health Assessment"].sample(rand(1..3)).join(', '),
    co_contact_type: ["Email", "Phone", "Text Message"].sample,
    engl_prof: ["A1","A2","B1","B2","C1","C2"].sample,
  )
end
