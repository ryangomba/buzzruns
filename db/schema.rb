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

ActiveRecord::Schema.define(:version => 20111006030956) do

  create_table "athletes", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "sex"
    t.integer  "year"
    t.string   "metrics"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "athletes_performances", :id => false, :force => true do |t|
    t.integer "athlete_id"
    t.integer "performance_id"
  end

  create_table "entries", :force => true do |t|
    t.integer  "athlete_id"
    t.integer  "milage"
    t.text     "notes"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entries", ["athlete_id"], :name => "index_entries_on_athlete_id"

  create_table "events", :force => true do |t|
    t.string   "name"
    t.boolean  "team"
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meets", :force => true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "city"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "performances", :force => true do |t|
    t.integer  "event_id"
    t.integer  "place"
    t.integer  "mark"
    t.integer  "meet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "season_type", :default => 2
    t.date     "date"
  end

  add_index "performances", ["event_id"], :name => "index_performances_on_event_id"
  add_index "performances", ["meet_id"], :name => "index_performances_on_meet_id"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "password_digest"
    t.boolean  "admin"
    t.integer  "athlete_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["athlete_id"], :name => "index_users_on_athlete_id"

end
