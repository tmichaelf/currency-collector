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

ActiveRecord::Schema[8.0].define(version: 2025_08_05_223859) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "currencies", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "country"
    t.text "description"
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "currency_collections", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "currency_denomination_id", null: false
    t.integer "quantity"
    t.string "condition"
    t.text "notes"
    t.date "acquired_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_denomination_id"], name: "index_currency_collections_on_currency_denomination_id"
    t.index ["user_id"], name: "index_currency_collections_on_user_id"
  end

  create_table "currency_denominations", force: :cascade do |t|
    t.bigint "currency_id", null: false
    t.string "name"
    t.decimal "value"
    t.string "denomination_type"
    t.integer "year_introduced"
    t.integer "year_discontinued"
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_id"], name: "index_currency_denominations_on_currency_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "currency_collections", "currency_denominations"
  add_foreign_key "currency_collections", "users"
  add_foreign_key "currency_denominations", "currencies"
end
