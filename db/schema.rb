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

ActiveRecord::Schema.define(version: 20160917161922) do

  create_table "holidays", force: :cascade do |t|
    t.string "yyyy", limit: 255, null: false
    t.string "mm",   limit: 255, null: false
    t.string "dd",   limit: 255, null: false
    t.string "name", limit: 255
  end

  add_index "holidays", ["yyyy", "mm", "dd"], name: "index_holidays_on_yyyy_and_mm_and_dd", unique: true, using: :btree

  create_table "kintais", force: :cascade do |t|
    t.string  "shain_no",      limit: 255,                                       null: false
    t.string  "yyyy",          limit: 255,                                       null: false
    t.string  "mm",            limit: 255,                                       null: false
    t.string  "dd",            limit: 255,                                       null: false
    t.string  "kintai_kbn_cd", limit: 255
    t.time    "start_time"
    t.time    "end_time"
    t.decimal "normal_hours",              precision: 3, scale: 1, default: 7.5
    t.decimal "break_hours",               precision: 3, scale: 1, default: 1.0
  end

  add_index "kintais", ["shain_no", "yyyy", "mm", "dd"], name: "index_kintais_on_shain_no_and_yyyy_and_mm_and_dd", unique: true, using: :btree

  create_table "shains", force: :cascade do |t|
    t.string  "no",          limit: 3,                  null: false
    t.string  "name",        limit: 255
    t.string  "name_kana",   limit: 255
    t.string  "login_id",    limit: 255
    t.string  "login_pw",    limit: 255
    t.string  "shain_kbn",   limit: 255
    t.boolean "zaiseki_flg",             default: true
  end

  add_index "shains", ["no"], name: "index_shains_on_no", using: :btree

end
