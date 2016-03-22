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

ActiveRecord::Schema.define(version: 20160322104323) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.string   "content"
    t.integer  "track_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["track_id"], name: "index_comments_on_track_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "tracks", force: :cascade do |t|
    t.string   "name"
    t.string   "genre"
    t.string   "version"
    t.integer  "user_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "soundcloud_id"
    t.datetime "soundcloud_created_at"
    t.integer  "soundcloud_user_id"
    t.integer  "soundcloud_duration"
    t.string   "soundcloud_tag_list"
    t.string   "soundcloud_genre"
    t.string   "soundcloud_description"
    t.string   "soundcloud_title"
    t.string   "soundcloud_track_type"
    t.string   "soundcloud_license"
    t.integer  "soundcloud_user_playback_count"
    t.string   "soundcloud_permalink_url"
    t.string   "soundcloud_stream_url"
    t.string   "soundcloud_download_url"
    t.string   "soundcloud_waveform_url"
    t.integer  "soundcloud_playback_count"
    t.integer  "soundcloud_download_count"
    t.integer  "soundcloud_favoritings_count"
    t.integer  "soundcloud_comment_count"
    t.string   "soundcloud_uri"
    t.string   "soundcloud_artwork_url"
    t.boolean  "soundcloud_downloadable"
    t.boolean  "soundcloud_user_favorite"
  end

  add_index "tracks", ["user_id"], name: "index_tracks_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "photo_url"
    t.string   "city"
    t.string   "country"
    t.text     "description"
    t.integer  "followers_count"
    t.integer  "public_favorites_count"
    t.integer  "upload_seconds_left"
    t.integer  "uid"
    t.string   "token"
    t.boolean  "admin",                  default: false, null: false
    t.string   "refresh_token"
    t.datetime "token_expires_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "track_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "votes", ["track_id"], name: "index_votes_on_track_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

  add_foreign_key "comments", "tracks"
  add_foreign_key "comments", "users"
  add_foreign_key "tracks", "users"
  add_foreign_key "votes", "tracks"
  add_foreign_key "votes", "users"
end
