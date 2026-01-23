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

ActiveRecord::Schema[7.2].define(version: 2026_01_23_105310) do
  create_table "common_foods", force: :cascade do |t|
    t.string "name", null: false
    t.integer "calories_per_serving", null: false
    t.string "serving_size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "protein"
    t.decimal "fat"
    t.decimal "carbs"
    t.decimal "fiber"
    t.decimal "sugar"
    t.decimal "sodium"
    t.decimal "base_quantity", precision: 8, scale: 2, default: "1.0"
    t.index ["name"], name: "index_common_foods_on_name", unique: true
  end

  create_table "foods", force: :cascade do |t|
    t.string "name", null: false
    t.integer "calories", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.decimal "protein"
    t.decimal "fat"
    t.decimal "carbs"
    t.decimal "fiber"
    t.decimal "sugar"
    t.decimal "sodium"
    t.index ["user_id"], name: "index_foods_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "foods", "users"
end
