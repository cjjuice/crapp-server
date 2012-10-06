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

ActiveRecord::Schema.define(:version => 20121006185011) do

  create_table "bathrooms", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "lat"
    t.string   "lng"
    t.boolean  "isHandicapAccessible"
    t.boolean  "isPublic"
    t.boolean  "isFamily"
    t.boolean  "isGreen"
    t.boolean  "isUnisex"
    t.boolean  "isHandsFree"
    t.boolean  "hasProductDispenser"
    t.boolean  "hasAttendent"
    t.boolean  "hasSignage"
    t.boolean  "hasWifi"
    t.integer  "bathroomtype_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "bathrooms", ["bathroomtype_id"], :name => "index_bathrooms_on_bathroomtype_id"

  create_table "bathroomtypes", :force => true do |t|
    t.string   "btype"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reviews", :force => true do |t|
    t.string   "reviewtext"
    t.integer  "bathroom_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "reviews", ["bathroom_id"], :name => "index_reviews_on_bathroom_id"

  create_table "scores", :force => true do |t|
    t.integer  "value"
    t.integer  "bathroom_id"
    t.integer  "scoretype_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "scores", ["bathroom_id"], :name => "index_scores_on_bathroom_id"
  add_index "scores", ["scoretype_id"], :name => "index_scores_on_scoretype_id"

  create_table "scoretypes", :force => true do |t|
    t.string   "stype"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
