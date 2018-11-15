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

ActiveRecord::Schema.define(:version => 20140205121204) do

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "section"
    t.string   "semester"
    t.integer  "teacher_id"
    t.integer  "department_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "courses", ["department_id"], :name => "index_courses_on_department_id"
  add_index "courses", ["teacher_id"], :name => "index_courses_on_teacher_id"

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "program_id"
    t.integer  "courses_count", :default => 0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "departments", ["program_id", "name"], :name => "index_departments_on_program_id_and_name", :unique => true
  add_index "departments", ["program_id"], :name => "index_departments_on_program_id"

  create_table "focuses", :force => true do |t|
    t.string   "name"
    t.boolean  "active",     :default => true
    t.integer  "school_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "focuses", ["active"], :name => "index_focuses_on_active"
  add_index "focuses", ["school_id"], :name => "index_focuses_on_school_id"

  create_table "interactions", :force => true do |t|
    t.integer  "observation_id"
    t.integer  "teacher"
    t.integer  "students"
    t.integer  "grouping"
    t.integer  "topic"
    t.boolean  "using_technology", :default => false
    t.integer  "on_task"
    t.integer  "minute"
    t.text     "note"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "interactions", ["observation_id"], :name => "index_interactions_on_observation_id"

  create_table "observation_focuses", :force => true do |t|
    t.integer  "observation_id"
    t.integer  "focus_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "observation_focuses", ["focus_id"], :name => "index_observation_focuses_on_focus_id"
  add_index "observation_focuses", ["observation_id"], :name => "index_observation_focuses_on_observation_id"

  create_table "observations", :force => true do |t|
    t.integer  "course_id"
    t.integer  "teacher_id"
    t.integer  "user_id"
    t.date     "observed_on"
    t.string   "period"
    t.integer  "number_of_students"
    t.boolean  "observer_confidence", :default => false
    t.text     "feedback"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "interactions_count",  :default => 0
  end

  add_index "observations", ["course_id", "teacher_id"], :name => "index_observations_on_course_id_and_teacher_id"
  add_index "observations", ["course_id"], :name => "index_observations_on_course_id"
  add_index "observations", ["teacher_id"], :name => "index_observations_on_teacher_id"
  add_index "observations", ["user_id"], :name => "index_observations_on_user_id"

  create_table "programs", :force => true do |t|
    t.string   "title"
    t.integer  "school_id"
    t.integer  "courses_count", :default => 0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "programs", ["school_id"], :name => "index_programs_on_school_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.string   "town"
    t.string   "country"
    t.datetime "deleted_at"
    t.string   "teacher_code"
    t.string   "observer_code"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "snapshots", :force => true do |t|
    t.integer  "interaction_id"
    t.string   "media_file_name"
    t.string   "media_content_type"
    t.integer  "media_file_size"
    t.datetime "media_updated_at"
    t.text     "note"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "snapshots", ["interaction_id"], :name => "index_snapshots_on_interaction_id"

  create_table "teachers", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "school_id"
    t.integer  "user_id"
    t.string   "registration_code"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "teachers", ["school_id", "registration_code"], :name => "index_teachers_on_school_id_and_registration_code", :unique => true
  add_index "teachers", ["school_id"], :name => "index_teachers_on_school_id"
  add_index "teachers", ["user_id"], :name => "index_teachers_on_user_id"

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
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "school_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "uuids", :force => true do |t|
    t.string  "uuid"
    t.integer "uuidable_id"
    t.string  "uuidable_type", :limit => 40
  end

  add_index "uuids", ["uuidable_id", "uuidable_type"], :name => "index_uuids_on_uuidable_id_and_uuidable_type"

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
