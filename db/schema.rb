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

ActiveRecord::Schema.define(version: 2019_03_28_215644) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.bigint "unknown_id"
    t.bigint "author_id", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_comments_on_author_id"
    t.index ["unknown_id"], name: "index_comments_on_unknown_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "triggerable_type"
    t.bigint "triggerable_id"
    t.bigint "user_id"
    t.string "event_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "accounted_for", default: false
    t.index ["triggerable_type", "triggerable_id"], name: "index_events_on_triggerable_type_and_triggerable_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "foci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "unknown_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unknown_id"], name: "index_foci_on_unknown_id"
    t.index ["user_id"], name: "index_foci_on_user_id"
  end

  create_table "insights", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.bigint "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_insights_on_author_id"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
  end

  create_table "project_members", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_members_on_project_id"
    t.index ["user_id"], name: "index_project_members_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.boolean "is_private", default: true, null: false
    t.string "slug", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_projects_on_slug", unique: true
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "proofs", force: :cascade do |t|
    t.bigint "insight_id"
    t.bigint "unknown_id"
    t.bigint "author_id", null: false
    t.integer "confidence", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_proofs_on_author_id"
    t.index ["insight_id"], name: "index_proofs_on_insight_id"
    t.index ["unknown_id"], name: "index_proofs_on_unknown_id"
  end

  create_table "support_messages", force: :cascade do |t|
    t.string "status"
    t.integer "order"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "project_id"
    t.string "rule_object_type", default: "None"
    t.string "rule_event_type", default: "create"
    t.integer "rule_occurrences", default: 1
  end

  create_table "unknowns", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.bigint "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "project_id"
    t.index ["author_id"], name: "index_unknowns_on_author_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_staff", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "unknowns"
  add_foreign_key "events", "users"
  add_foreign_key "foci", "unknowns"
  add_foreign_key "foci", "users"
  add_foreign_key "proofs", "insights"
  add_foreign_key "proofs", "unknowns"
  add_foreign_key "unknowns", "projects"
end
