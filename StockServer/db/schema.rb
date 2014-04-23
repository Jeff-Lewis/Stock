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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140423053910) do

  create_table "beat_misses", :force => true do |t|
    t.integer  "erdate_id"
    t.integer  "user_id"
    t.integer  "beat"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "details", :force => true do |t|
    t.integer  "stock_id"
    t.float    "yearMin"
    t.float    "yearMax"
    t.float    "avgVol"
    t.string   "marketCap"
    t.float    "pe"
    t.float    "eps"
    t.float    "divYield"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "erdates", :force => true do |t|
    t.integer  "stock_id"
    t.datetime "datetime"
    t.float    "estimate",   :default => 0.0
    t.float    "value",      :default => 0.0
    t.string   "confcall"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "beat_cnt"
    t.integer  "miss_cnt"
  end

  create_table "erdates_users", :force => true do |t|
    t.integer "user_id"
    t.integer "erdate_id"
  end

  add_index "erdates_users", ["user_id", "erdate_id"], :name => "index_users_erdates_on_user_id_and_erdate_id", :unique => true

  create_table "exchanges", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "popularities", :force => true do |t|
    t.integer  "stock_id"
    t.integer  "total",      :default => 0
    t.integer  "trend",      :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "username",            :default => "Too lazy to have a name"
    t.integer  "beat",                :default => 0
    t.integer  "miss",                :default => 0
    t.integer  "success",             :default => 0
    t.integer  "failure",             :default => 0
    t.integer  "rank",                :default => 0
    t.integer  "bullism",             :default => 1
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "stocks", :force => true do |t|
    t.string   "name"
    t.string   "symbol"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "exchange_id"
  end

  create_table "stocks_users", :force => true do |t|
    t.integer "user_id"
    t.integer "stock_id"
  end

  add_index "stocks_users", ["user_id", "stock_id"], :name => "index_users_stocks_on_user_id_and_stock_id", :unique => true

  create_table "user_relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followee_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "user_relationships", ["followee_id"], :name => "index_user_relationships_on_followee_id"
  add_index "user_relationships", ["follower_id", "followee_id"], :name => "index_user_relationships_on_follower_id_and_followee_id", :unique => true
  add_index "user_relationships", ["follower_id"], :name => "index_user_relationships_on_follower_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "authentication_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
