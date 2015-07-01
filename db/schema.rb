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

ActiveRecord::Schema.define(version: 20150701200456) do

  create_table "users", force: :cascade do |t|
    t.string   "email",            limit: 255,                  null: false
    t.string   "password_digest",  limit: 255,                  null: false
    t.string   "role",             limit: 255, default: "user", null: false
    t.string   "first_name",       limit: 255,                  null: false
    t.string   "last_name",        limit: 255,                  null: false
    t.string   "nickname",         limit: 255,                  null: false
    t.boolean  "use_full_name",                                 null: false
    t.boolean  "incl_in_thesis",                                null: false
    t.boolean  "incl_in_rankings",                              null: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

end
