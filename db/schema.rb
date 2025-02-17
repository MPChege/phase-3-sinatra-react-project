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

ActiveRecord::Schema.define(version: 2023_06_07_083556) do

  create_table "categories", force: :cascade do |t|
    t.string "category"
  end

  create_table "houses", force: :cascade do |t|
    t.integer "location_id"
    t.integer "category_id"
    t.integer "seller_id"
    t.float "price"
    t.string "description"
    t.integer "size_in_sqft"
    t.string "image"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
  end

  create_table "sellers", force: :cascade do |t|
    t.string "name"
  end

end
