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

ActiveRecord::Schema.define(:version => 20110113230051) do

  create_table "users", :force => true do |t|
    t.string   "email_address"
    t.boolean  "confirmed"
    t.string   "time_zone_string"
    t.string   "location_string"
    t.integer  "time_zone_offset"
    t.integer  "woeid"
    t.integer  "seconds_since_midnight"
    t.string   "confirm_guid"
    t.datetime "last_reminder_sent_at"
  end

end
