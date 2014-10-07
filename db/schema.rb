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

ActiveRecord::Schema.define(version: 20141007140941) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: true do |t|
    t.integer  "book_id"
    t.string   "title"
    t.string   "image"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "douban_auth_infos", force: true do |t|
    t.string   "access_token"
    t.string   "douban_user_name"
    t.string   "douban_user_id"
    t.integer  "expires_in"
    t.string   "refresh_token"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups_users", id: false, force: true do |t|
    t.integer "group_id"
    t.integer "user_id"
  end

  create_table "read_records", force: true do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.integer  "rating"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.string   "douban_id"
    t.string   "douban_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
