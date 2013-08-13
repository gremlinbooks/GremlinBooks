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

ActiveRecord::Schema.define(:version => 20130813163007) do

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "comments"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "search_logs", :force => true do |t|
    t.string   "search_term"
    t.string   "user"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "vendor"
  end

  create_table "tenants", :force => true do |t|
    t.string   "amazon_access_key"
    t.string   "amazon_secret_key"
    t.string   "amazon_associate_tag"
    t.string   "bookbyte_base_url"
    t.string   "bookbyte_auth_token"
    t.string   "bookbyte_publisher_id"
    t.string   "cj_website_id"
    t.string   "cj_auth_key"
    t.string   "cj_base_url"
    t.string   "bookrenter_base_url"
    t.string   "bookrenter_developer_key"
    t.string   "chegg_base_url"
    t.string   "chegg_password"
    t.string   "chegg_key"
    t.string   "chegg_aid"
    t.string   "chegg_pid"
    t.string   "chegg_sid"
    t.string   "logo"
    t.string   "color"
    t.string   "title"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "user_buy_logs", :force => true do |t|
    t.string   "user"
    t.string   "isbn"
    t.string   "link"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.decimal  "affiliate_percent"
    t.decimal  "item_cost"
  end

  create_table "user_search_logs", :force => true do |t|
    t.string   "search_term"
    t.string   "user"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
