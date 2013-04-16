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

ActiveRecord::Schema.define(:version => 20130129215330) do

  create_table "boards", :force => true do |t|
    t.integer  "user_id"
    t.integer  "story_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "boards", ["name", "story_id"], :name => "index_boards_on_name_and_story_id", :unique => true
  add_index "boards", ["name"], :name => "index_boards_on_name"
  add_index "boards", ["story_id"], :name => "index_boards_on_story_id"
  add_index "boards", ["user_id"], :name => "index_boards_on_user_id"

  create_table "comments", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "story_id"
    t.integer  "rating"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["rating"], :name => "index_comments_on_rating"
  add_index "comments", ["user_id", "created_at"], :name => "index_comments_on_user_id_and_created_at"

  create_table "genres", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "genres", ["name"], :name => "index_genres_on_name", :unique => true

  create_table "relationships", :force => true do |t|
    t.integer  "reader_id"
    t.integer  "publisher_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "relationships", ["publisher_id"], :name => "index_relationships_on_publisher_id"
  add_index "relationships", ["reader_id", "publisher_id"], :name => "index_relationships_on_reader_id_and_publisher_id", :unique => true
  add_index "relationships", ["reader_id"], :name => "index_relationships_on_reader_id"

  create_table "stats", :force => true do |t|
    t.integer  "viewer_id"
    t.boolean  "viewed",     :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "story_id"
    t.boolean  "rated",      :default => false
  end

  add_index "stats", ["viewed"], :name => "index_stats_on_viewed"
  add_index "stats", ["viewer_id"], :name => "index_stats_on_viewer_id"

  create_table "stories", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "blurb"
    t.text     "content"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "primary_genre_id"
    t.integer  "secondary_genre_id"
    t.integer  "tertiary_genre_id"
    t.integer  "upvotes"
  end

  add_index "stories", ["created_at"], :name => "index_stories_on_created_at"
  add_index "stories", ["primary_genre_id"], :name => "index_stories_on_primary_genre_id"
  add_index "stories", ["secondary_genre_id"], :name => "index_stories_on_secondary_genre_id"
  add_index "stories", ["tertiary_genre_id"], :name => "index_stories_on_tertiary_genre_id"
  add_index "stories", ["title"], :name => "index_stories_on_title"
  add_index "stories", ["user_id"], :name => "index_stories_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",             :default => false
    t.integer  "community_points",  :default => 0
    t.integer  "storyboard_points", :default => 0
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
