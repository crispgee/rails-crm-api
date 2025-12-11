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

ActiveRecord::Schema[8.1].define(version: 2025_12_10_140233) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "companies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "industry"
    t.string "name"
    t.string "registration_number"
    t.string "status"
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "status"
    t.datetime "updated_at", null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.bigint "customer_id", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_memberships_on_company_id"
    t.index ["customer_id"], name: "index_memberships_on_customer_id"
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount"
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.string "currency"
    t.bigint "customer_id", null: false
    t.datetime "paid_at"
    t.string "reference"
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_payments_on_company_id"
    t.index ["customer_id"], name: "index_payments_on_customer_id"
  end

  create_table "withdrawals", force: :cascade do |t|
    t.decimal "amount"
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.string "currency"
    t.bigint "customer_id", null: false
    t.datetime "processed_at"
    t.datetime "requested_at"
    t.string "status"
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_withdrawals_on_company_id"
    t.index ["customer_id"], name: "index_withdrawals_on_customer_id"
  end

  add_foreign_key "memberships", "companies"
  add_foreign_key "memberships", "customers"
  add_foreign_key "payments", "companies"
  add_foreign_key "payments", "customers"
  add_foreign_key "withdrawals", "companies"
  add_foreign_key "withdrawals", "customers"
end
