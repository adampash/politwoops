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

ActiveRecord::Schema.define(:version => 20120905195444) do

  create_table "account_links", :force => true do |t|
    t.integer "politician_id"
    t.integer "linked_id"
  end

  create_table "account_types", :force => true do |t|
    t.string "type"
  end

  create_table "deleted_tweets", :force => true do |t|
    t.string   "user_name",      :limit => 64
    t.string   "content"
    t.boolean  "deleted",                      :default => false, :null => false
    t.datetime "created",                                         :null => false
    t.datetime "modified",                                        :null => false
    t.text     "tweet"
    t.integer  "politician_id"
    t.boolean  "typo_checked"
    t.boolean  "approved"
    t.boolean  "reviewed"
    t.datetime "reviewed_at"
    t.text     "review_message"
  end

  add_index "deleted_tweets", ["approved"], :name => "index_deleted_tweets_on_approved"
  add_index "deleted_tweets", ["content"], :name => "index_tweets_on_content"
  add_index "deleted_tweets", ["created"], :name => "created"
  add_index "deleted_tweets", ["deleted"], :name => "deleted"
  add_index "deleted_tweets", ["modified"], :name => "modified"
  add_index "deleted_tweets", ["politician_id"], :name => "index_tweets_on_politician_id"
  add_index "deleted_tweets", ["reviewed"], :name => "index_deleted_tweets_on_reviewed"
  add_index "deleted_tweets", ["typo_checked"], :name => "index_deleted_tweets_on_typo_checked"
  add_index "deleted_tweets", ["user_name"], :name => "user_name"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.string   "full_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "language",        :limit => 12, :default => "en"
    t.boolean  "hide",                          :default => false
    t.text     "sponsor"
    t.string   "consumer_key"
    t.string   "consumer_secret"
    t.string   "oauth_token"
    t.string   "oauth_secret"
    t.string   "base_url",                      :default => "http://www.politwoops.nl"
    t.string   "flag"
    t.boolean  "is_domain"
  end

  add_index "groups", ["flag"], :name => "index_groups_on_flag"
  add_index "groups", ["is_domain"], :name => "index_groups_on_is_domain"
  add_index "groups", ["name"], :name => "index_groups_on_name"

  create_table "groups_politicians", :id => false, :force => true do |t|
    t.integer "politician_id"
    t.integer "group_id"
  end

  add_index "groups_politicians", ["politician_id", "group_id"], :name => "index_groups_politicians_on_politician_id_and_group_id"

  create_table "offices", :force => true do |t|
    t.string "title",        :null => false
    t.string "abbreviation", :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "language"
  end

  add_index "pages", ["language"], :name => "index_pages_on_language"

  create_table "parties", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "politicians", :force => true do |t|
    t.string  "user_name",         :limit => 64,                :null => false
    t.integer "twitter_id",                                     :null => false
    t.integer "party_id"
    t.integer "status",                          :default => 1
    t.string  "profile_image_url"
    t.string  "state"
    t.integer "account"
    t.integer "office"
  end

  add_index "politicians", ["status"], :name => "index_politicians_on_status"
  add_index "politicians", ["user_name"], :name => "user_name"

  create_table "statistics", :force => true do |t|
    t.string   "what"
    t.date     "when"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweet_images", :force => true do |t|
    t.string   "url"
    t.integer  "tweet_id",   :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweets", :force => true do |t|
    t.string   "user_name",      :limit => 64
    t.string   "content"
    t.boolean  "deleted",                      :default => false, :null => false
    t.datetime "created",                                         :null => false
    t.datetime "modified",                                        :null => false
    t.text     "tweet"
    t.integer  "politician_id"
    t.boolean  "typo_checked",                 :default => false
    t.boolean  "approved",                     :default => false
    t.boolean  "reviewed",                     :default => false
    t.datetime "reviewed_at"
    t.text     "review_message"
  end

  add_index "tweets", ["approved"], :name => "index_tweets_on_approved"
  add_index "tweets", ["content"], :name => "index_tweets_on_content"
  add_index "tweets", ["created"], :name => "created"
  add_index "tweets", ["deleted"], :name => "deleted"
  add_index "tweets", ["modified"], :name => "modified"
  add_index "tweets", ["politician_id"], :name => "index_tweets_on_politician_id"
  add_index "tweets", ["reviewed"], :name => "index_tweets_on_reviewed"
  add_index "tweets", ["typo_checked"], :name => "index_tweets_on_typo_checked"
  add_index "tweets", ["user_name"], :name => "user_name"

  create_table "users", :force => true do |t|
    t.string   "login",                              :null => false
    t.string   "email",                              :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
    t.integer  "is_admin"
  end

end
