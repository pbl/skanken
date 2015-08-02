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

ActiveRecord::Schema.define(version: 20150802055752) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "cooperative_id"
    t.string   "name"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "activities", ["cooperative_id"], name: "index_activities_on_cooperative_id", using: :btree

  create_table "contacteds", force: :cascade do |t|
    t.date     "date"
    t.string   "activity"
    t.text     "comment"
    t.integer  "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "contacteds", ["member_id"], name: "index_contacteds_on_member_id", using: :btree

  create_table "cooperatives", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.date     "date"
    t.string   "activity"
    t.text     "comment"
    t.integer  "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "jobs", ["member_id"], name: "index_jobs_on_member_id", using: :btree

  create_table "member_activities", force: :cascade do |t|
    t.integer  "activity_id"
    t.integer  "member_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "member_activities", ["activity_id"], name: "index_member_activities_on_activity_id", using: :btree
  add_index "member_activities", ["member_id"], name: "index_member_activities_on_member_id", using: :btree

  create_table "members", force: :cascade do |t|
    t.string   "name"
    t.string   "mobile"
    t.string   "email"
    t.string   "personId"
    t.string   "comment"
    t.string   "dateAdded"
    t.integer  "cooperative_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "nbr_jobs",       default: 0
    t.integer  "nbr_contacteds", default: 0
    t.string   "last_contacted", default: "Never contacted"
  end

  add_index "members", ["cooperative_id"], name: "index_members_on_cooperative_id", using: :btree

  create_table "user_activities", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "user_activities", ["activity_id"], name: "index_user_activities_on_activity_id", using: :btree
  add_index "user_activities", ["user_id"], name: "index_user_activities_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",        null: false
    t.string   "encrypted_password",     default: "",        null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,         null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cooperative_id"
    t.string   "role",                   default: "no_role"
  end

  add_index "users", ["cooperative_id"], name: "index_users_on_cooperative_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "activities", "cooperatives"
  add_foreign_key "contacteds", "members"
  add_foreign_key "jobs", "members"
  add_foreign_key "members", "cooperatives"
  add_foreign_key "users", "cooperatives"
end
