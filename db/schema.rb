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

ActiveRecord::Schema.define(:version => 20120828085455) do

  create_table "activos", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.string   "os"
  end

  create_table "activos_tags", :id => false, :force => true do |t|
    t.integer "activo_id"
    t.integer "tag_id"
  end

  create_table "ips", :force => true do |t|
    t.integer  "network_id"
    t.string   "ip"
    t.string   "hostname"
    t.boolean  "gw"
    t.boolean  "enabled"
    t.boolean  "reserved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "activo_id"
    t.boolean  "hpsrp"
    t.boolean  "temporal"
    t.boolean  "assigned",   :default => false
    t.string   "label"
    t.integer  "gw_id"
  end

  create_table "networks", :force => true do |t|
    t.string   "prefix"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "vlan_id"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "tags", :force => true do |t|
    t.string   "tag"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "persistence_token", :default => "t", :null => false
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "vlans", :force => true do |t|
    t.integer  "tag"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
