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

ActiveRecord::Schema.define(version: 20121128093616) do

  create_table "custom_boxes", force: true do |t|
    t.string   "title"
    t.string   "type"
    t.boolean  "is_required"
    t.boolean  "editable"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "custom_fields", force: true do |t|
    t.integer  "custom_box_id"
    t.string   "title"
    t.string   "unit"
    t.string   "field_format"
    t.text     "possible_values"
    t.string   "regexp"
    t.integer  "min_length"
    t.integer  "max_length"
    t.integer  "position"
    t.text     "default_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "custom_fields", ["custom_box_id"], name: "index_custom_fields_on_custom_box_id"

  create_table "custom_values", force: true do |t|
    t.integer  "custom_box_id"
    t.integer  "custom_field_id"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "custom_values", ["custom_box_id", "custom_field_id"], name: "index_custom_values_on_custom_box_id_and_custom_field_id"
  add_index "custom_values", ["custom_field_id"], name: "index_custom_values_on_custom_field_id"

  create_table "users", force: true do |t|
    t.integer  "custom_field_id"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
