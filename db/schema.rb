# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_11_30_014151) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "anzsco_codes", force: :cascade do |t|
    t.integer "anzsco_code"
    t.string "occupation"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cases", force: :cascade do |t|
    t.bigint "users_id"
    t.bigint "countries_id"
    t.bigint "anzsco_codes_id"
    t.bigint "visas_id"
    t.date "lodgement_date"
    t.date "co_contact_date"
    t.date "co_response_date"
    t.date "grant_date"
    t.date "assess_comence"
    t.integer "grant_days"
    t.integer "days_to_co_contact"
    t.integer "days_grant_aftr_co_contact"
    t.integer "work_p_claim"
    t.integer "total_p"
    t.integer "days_aftr_assess"
    t.boolean "on_off_shore"
    t.boolean "case_status"
    t.boolean "agency"
    t.boolean "employment_verification"
    t.boolean "active"
    t.string "sponsor_state"
    t.string "documents"
    t.string "co_contact_type"
    t.string "engl_prof"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["anzsco_codes_id"], name: "index_cases_on_anzsco_codes_id"
    t.index ["countries_id"], name: "index_cases_on_countries_id"
    t.index ["users_id"], name: "index_cases_on_users_id"
    t.index ["visas_id"], name: "index_cases_on_visas_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "logs", force: :cascade do |t|
    t.string "log_type"
    t.text "message"
    t.bigint "user_id"
    t.jsonb "context"
    t.integer "status_code"
    t.string "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_logs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "role", default: "member"
    t.datetime "last_login_at"
    t.string "status", default: "active"
    t.boolean "is_admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "visa_categories", force: :cascade do |t|
    t.string "name"
    t.string "about"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "visas", force: :cascade do |t|
    t.string "name"
    t.integer "subclass"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "visa_category_id", null: false
    t.index ["visa_category_id"], name: "index_visas_on_visa_category_id"
  end

  create_table "yearly_migration_data", force: :cascade do |t|
    t.string "financial_year"
    t.string "country_code"
    t.string "country_name"
    t.integer "migration_value"
    t.string "sheet_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "cases", "anzsco_codes", column: "anzsco_codes_id"
  add_foreign_key "cases", "countries", column: "countries_id"
  add_foreign_key "cases", "users", column: "users_id"
  add_foreign_key "cases", "visas", column: "visas_id"
  add_foreign_key "logs", "users"
  add_foreign_key "visas", "visa_categories"
end
