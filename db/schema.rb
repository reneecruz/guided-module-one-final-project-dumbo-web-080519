# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190816221153) do

  create_table "gigs", force: :cascade do |t|
    t.integer  "musician_id"
    t.integer  "venue_id"
    t.string   "name"
    t.string   "description"
    t.integer  "price"
    t.datetime "database"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "musicians", force: :cascade do |t|
    t.string   "name"
    t.text     "bio"
    t.string   "website_url"
    t.string   "instrument"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "venues", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.string   "website_url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
