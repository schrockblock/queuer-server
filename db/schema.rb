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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171125005423) do

  create_table "day_tasks", force: :cascade do |t|
    t.integer  "day_id"
    t.integer  "task_id"
    t.integer  "next_id"
    t.integer  "previous_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "days", force: :cascade do |t|
    t.datetime "date"
    t.integer  "sprint_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "color"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id"
  end

  create_table "sprint_projects", force: :cascade do |t|
    t.integer  "sprint_id"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sprints", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "order"
    t.boolean  "finished"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "project_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",        limit: 255
    t.string   "password",        limit: 255
    t.boolean  "admin"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "api_key",         limit: 255
    t.string   "password_digest", limit: 255
  end

end
