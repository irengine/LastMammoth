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

ActiveRecord::Schema.define(:version => 20090714023944) do

  create_table "custom_queries", :force => true do |t|
    t.string   "name",                       :null => false
    t.text     "syntax",                     :null => false
    t.string   "action"
    t.string   "summary"
    t.integer  "page",       :default => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "custom_query_columns", :force => true do |t|
    t.integer  "query_id",   :null => false
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "custom_query_parameters", :force => true do |t|
    t.integer  "query_id",   :null => false
    t.string   "name",       :null => false
    t.string   "flag"
    t.string   "syntax"
    t.string   "code"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employee_cloths", :force => true do |t|
    t.integer  "employee_id"
    t.date     "get_date"
    t.string   "get_type"
    t.string   "get_model"
    t.integer  "get_quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employee_funds", :force => true do |t|
    t.integer  "employee_id"
    t.integer  "fund_type_id"
    t.date     "fund_date"
    t.integer  "fund_address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employee_records", :force => true do |t|
    t.integer  "employee_id"
    t.date     "record_date"
    t.string   "reason"
    t.string   "result"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employee_statuses", :force => true do |t|
    t.integer  "employee_id"
    t.integer  "branch_id"
    t.integer  "group_id"
    t.integer  "team_id"
    t.string   "flag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", :force => true do |t|
    t.integer  "default_group_id"
    t.string   "name"
    t.integer  "gender_id"
    t.date     "birthdate"
    t.string   "id_card_number"
    t.string   "license_number"
    t.string   "employee_number"
    t.integer  "height"
    t.string   "phone_number"
    t.string   "mobile_number"
    t.integer  "political_status_id"
    t.integer  "educational_attainments_id"
    t.integer  "person_type_id"
    t.boolean  "is_demobilized"
    t.string   "permanent_residence"
    t.integer  "employee_type_id"
    t.string   "home_address"
    t.integer  "fund_type_id"
    t.date     "fund_date"
    t.integer  "fund_address_id"
    t.integer  "training_status_id"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entries", :force => true do |t|
    t.integer  "feature_id", :default => 0, :null => false
    t.integer  "role_id",    :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "features", :force => true do |t|
    t.string   "name",            :null => false
    t.string   "controller_name", :null => false
    t.string   "action_name",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "root_id"
    t.string   "type"
    t.integer  "lv"
    t.string   "name"
    t.string   "description"
    t.string   "contacts"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_histories", :force => true do |t|
    t.integer  "employee_id"
    t.string   "history_type"
    t.integer  "source_branch_id"
    t.integer  "source_group_id"
    t.integer  "source_site_id"
    t.string   "source_job_name"
    t.string   "source_job_title"
    t.date     "source_begin_date"
    t.date     "source_end_date"
    t.text     "source_remark"
    t.integer  "target_branch_id"
    t.integer  "target_group_id"
    t.integer  "target_site_id"
    t.string   "target_job_name"
    t.string   "target_job_title"
    t.date     "target_begin_date"
    t.date     "target_end_date"
    t.text     "target_remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions", :force => true do |t|
    t.integer  "role_id",    :default => 0, :null => false
    t.integer  "user_id",    :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.integer  "employee_id"
    t.integer  "parent_id"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resources", :force => true do |t|
    t.string   "scope",                            :null => false
    t.string   "klass",      :default => "String", :null => false
    t.string   "key",                              :null => false
    t.string   "value",                            :null => false
    t.string   "mode",       :default => "active", :null => false
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "site_contracts", :force => true do |t|
    t.integer  "site_id"
    t.date     "contract_begin_date"
    t.date     "contract_end_date"
    t.integer  "quantity"
    t.integer  "contract_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.integer  "default_group_id"
    t.string   "name",             :null => false
    t.string   "full_name"
    t.string   "email"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "working_experiences", :force => true do |t|
    t.integer  "employee_id"
    t.date     "begin_date"
    t.date     "end_date"
    t.string   "company_name"
    t.string   "job_title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
