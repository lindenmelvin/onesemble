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

ActiveRecord::Schema.define(:version => 20131022140703) do

  create_table "cities", :force => true do |t|
    t.integer "state_id"
    t.string  "name"
  end

  create_table "contracts", :force => true do |t|
    t.boolean  "complete",   :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "contracts_users", :force => true do |t|
    t.integer "user_id"
    t.integer "contract_id"
  end

  add_index "contracts_users", ["contract_id"], :name => "index_contracts_users_on_contract_id"
  add_index "contracts_users", ["user_id"], :name => "index_contracts_users_on_user_id"

  create_table "genres", :force => true do |t|
    t.string "name"
  end

  create_table "genres_posts", :force => true do |t|
    t.integer "genre_id"
    t.integer "post_id"
  end

  create_table "instruments", :force => true do |t|
    t.string "name"
  end

  create_table "instruments_posts", :force => true do |t|
    t.integer "instrument_id"
    t.integer "post_id"
  end

  create_table "messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.text     "body"
    t.string   "ancestry"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "read",        :default => false
  end

  add_index "messages", ["ancestry"], :name => "index_messages_on_ancestry"

  create_table "posts", :force => true do |t|
    t.string   "subject"
    t.string   "body"
    t.integer  "user_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "type"
    t.decimal  "rate"
    t.boolean  "hourly"
    t.integer  "state_id"
    t.integer  "city_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean  "all_day",    :default => false
  end

  add_index "posts", ["city_id"], :name => "index_posts_on_city_id"
  add_index "posts", ["state_id"], :name => "index_posts_on_state_id"

  create_table "ratings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "rater_id"
    t.integer  "contract_id"
    t.integer  "score"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "ratings", ["contract_id"], :name => "index_ratings_on_contract_id"
  add_index "ratings", ["rater_id"], :name => "index_ratings_on_rater_id"
  add_index "ratings", ["user_id"], :name => "index_ratings_on_user_id"

  create_table "recommendations", :force => true do |t|
    t.integer "user_id"
    t.integer "recommender_id"
    t.string  "subject"
    t.text    "body"
  end

  add_index "recommendations", ["recommender_id"], :name => "index_recommendations_on_recommender_id"
  add_index "recommendations", ["user_id"], :name => "index_recommendations_on_user_id"

  create_table "requests", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.boolean  "pending"
    t.boolean  "accepted"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "requests", ["receiver_id"], :name => "index_requests_on_receiver_id"
  add_index "requests", ["sender_id"], :name => "index_requests_on_sender_id"

  create_table "specialties", :force => true do |t|
    t.string "name"
  end

  create_table "specialties_posts", :force => true do |t|
    t.integer "specialty_id"
    t.integer "post_id"
  end

  create_table "states", :force => true do |t|
    t.string "name"
    t.string "abbreviation"
  end

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
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.decimal  "reputation"
    t.integer  "state_id"
    t.integer  "city_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
