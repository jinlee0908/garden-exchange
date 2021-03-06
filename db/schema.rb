# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140428050041) do

  create_table "categories", force: true do |t|
    t.string   "category"
    t.integer  "image_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "location"
    t.string   "encrypted_email"
    t.string   "phone"
    t.string   "state"
    t.integer  "image_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "slug"
  end

  add_index "items", ["slug"], name: "index_items_on_slug"

  create_table "locations", force: true do |t|
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trades", force: true do |t|
    t.integer  "item_id"
    t.string   "name"
    t.string   "comment"
    t.string   "trade_email"
    t.string   "phone_num"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
  end

end
