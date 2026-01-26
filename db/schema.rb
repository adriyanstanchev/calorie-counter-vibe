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

ActiveRecord::Schema[8.1].define(version: 2026_01_24_000001) do
  create_table "common_foods", force: :cascade do |t|
    t.decimal "base_quantity", precision: 8, scale: 2, default: "1.0"
    t.integer "calories_per_serving", null: false
    t.decimal "carbs"
    t.datetime "created_at", null: false
    t.decimal "fat"
    t.decimal "fiber"
    t.string "name", null: false
    t.decimal "protein"
    t.string "serving_size"
    t.decimal "sodium"
    t.decimal "sugar"
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_common_foods_on_name", unique: true
  end

  create_table "foods", force: :cascade do |t|
    t.integer "calories", null: false
    t.decimal "carbs"
    t.datetime "created_at", null: false
    t.decimal "fat"
    t.decimal "fiber"
    t.string "name", null: false
    t.decimal "protein"
    t.decimal "sodium"
    t.decimal "sugar"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_foods_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "activity_level"
    t.integer "age"
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "gender"
    t.string "goal"
    t.decimal "height", precision: 5, scale: 2
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.decimal "weight", precision: 5, scale: 2
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "foods", "users"
end
