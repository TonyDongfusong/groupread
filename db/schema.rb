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

ActiveRecord::Schema.define(version: 20141009141814) do

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

  add_index "books", ["book_id"], name: "index_books_on_book_id", unique: true, using: :btree
  add_index "books", ["image"], name: "index_books_on_image", unique: true, using: :btree
  add_index "books", ["url"], name: "index_books_on_url", unique: true, using: :btree

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

  add_index "douban_auth_infos", ["douban_user_id"], name: "index_douban_auth_infos_on_douban_user_id", unique: true, using: :btree
  add_index "douban_auth_infos", ["douban_user_name"], name: "index_douban_auth_infos_on_douban_user_name", unique: true, using: :btree

  create_table "groups", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["name"], name: "index_groups_on_name", unique: true, using: :btree

  create_table "groups_users", id: false, force: true do |t|
    t.integer "group_id"
    t.integer "user_id"
  end

  add_index "groups_users", ["group_id", "user_id"], name: "group_user_unique", unique: true, using: :btree

  create_table "read_records", force: true do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.integer  "rating"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "read_records", ["book_id", "user_id"], name: "book_user_unique", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salt"
    t.string   "encrypted_password"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
