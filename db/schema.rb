# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100109114509) do

  create_table "accounts", :force => true do |t|
    t.string   "username"
    t.string   "atoken"
    t.string   "asecret"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email_notifications", :default => "none"
    t.boolean  "auto_follow",         :default => true
    t.string   "bitly_token"
    t.string   "bitly_secret"
    t.boolean  "auto_unfollow",       :default => false
    t.text     "location"
  end

  create_table "feedback_entries", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "follower_people", :force => true do |t|
    t.integer  "search_id"
    t.integer  "account_id"
    t.text     "user"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.boolean  "mutual_follow", :default => false
  end

  create_table "links", :force => true do |t|
    t.string   "unique_hash"
    t.string   "user_hash"
    t.string   "long_url"
    t.string   "short_url"
    t.integer  "cached_clickcount",      :default => 0
    t.integer  "account_id"
    t.text     "referrers"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cached_user_clickcount", :default => 0
  end

  create_table "poll_answers", :force => true do |t|
    t.integer  "poll_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "poll_entries", :force => true do |t|
    t.integer  "user_id"
    t.integer  "poll_answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "polls", :force => true do |t|
    t.string   "title"
    t.boolean  "active",     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "search_condition_types", :force => true do |t|
    t.string   "operator"
    t.string   "label"
    t.boolean  "value_required", :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "processor"
  end

  create_table "search_conditions", :force => true do |t|
    t.integer  "search_condition_type_id"
    t.integer  "search_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searches", :force => true do |t|
    t.string   "title"
    t.integer  "account_id"
    t.boolean  "active",     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope",          :limit => 40
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "scope", "sequence"], :name => "index_slugs_on_name_and_sluggable_type_and_scope_and_sequence", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password", :limit => 128
    t.string   "salt",               :limit => 128
    t.string   "token",              :limit => 128
    t.datetime "token_expires_at"
    t.boolean  "email_confirmed",                   :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["id", "token"], :name => "index_users_on_id_and_token"
  add_index "users", ["token"], :name => "index_users_on_token"

end
