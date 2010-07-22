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

ActiveRecord::Schema.define(:version => 20100722132100) do

  create_table "users", :force => true do |t|
    t.string   "full_name"
    t.string   "tagline"
    t.text     "bio"
    t.string   "location"
    t.string   "company"
    t.string   "job_title"
    t.string   "website"
    t.string   "twitter_username"
    t.string   "linkedin_profile"
    t.string   "github_account"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "interests"
    t.string   "email"
    t.string   "phone_number"
    t.string   "blog_feed"
    t.string   "username"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.boolean  "active"
    t.string   "perishable_token"
    t.boolean  "agreed_tc_and_pp",   :default => false
    t.string   "bitbucket_account"
    t.string   "delicious_username"
  end

end
