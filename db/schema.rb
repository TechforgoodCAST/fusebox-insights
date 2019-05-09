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

ActiveRecord::Schema.define(version: 2019_05_08_155048) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assumptions", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.bigint "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "project_id", null: false
    t.bigint "group_id"
    t.integer "certainty", default: 0
    t.datetime "deleted_at"
    t.index ["author_id"], name: "index_assumptions_on_author_id"
    t.index ["deleted_at"], name: "index_assumptions_on_deleted_at"
    t.index ["group_id"], name: "index_assumptions_on_group_id"
    t.index ["project_id"], name: "index_assumptions_on_project_id"
  end

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "assumption_id"
    t.bigint "author_id", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assumption_id"], name: "index_comments_on_assumption_id"
    t.index ["author_id"], name: "index_comments_on_author_id"
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
    t.bigint "assumption_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assumption_id"], name: "index_foci_on_assumption_id"
    t.index ["user_id"], name: "index_foci_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.text "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "author_id", null: false
    t.bigint "project_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_groups_on_deleted_at"
    t.index ["project_id"], name: "index_groups_on_project_id"
  end

  create_table "insights", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.bigint "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "assumption_id"
    t.integer "confidence", default: 0, null: false
    t.index ["assumption_id"], name: "index_insights_on_assumption_id"
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
    t.string "role", default: "Admin"
    t.index ["project_id"], name: "index_project_members_on_project_id"
    t.index ["user_id"], name: "index_project_members_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.boolean "is_private", default: true, null: false
    t.string "slug", null: false
    t.bigint "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["author_id"], name: "index_projects_on_author_id"
    t.index ["deleted_at"], name: "index_projects_on_deleted_at"
    t.index ["slug"], name: "index_projects_on_slug", unique: true
  end

  create_table "proofs", force: :cascade do |t|
    t.bigint "insight_id"
    t.bigint "assumption_id"
    t.bigint "author_id", null: false
    t.integer "confidence", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assumption_id"], name: "index_proofs_on_assumption_id"
    t.index ["author_id"], name: "index_proofs_on_author_id"
    t.index ["insight_id"], name: "index_proofs_on_insight_id"
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
    t.string "subject"
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

  add_foreign_key "assumptions", "projects"
  add_foreign_key "comments", "assumptions"
  add_foreign_key "events", "users"
  add_foreign_key "foci", "assumptions"
  add_foreign_key "foci", "users"
  add_foreign_key "groups", "projects"
  add_foreign_key "insights", "assumptions"
  add_foreign_key "proofs", "assumptions"
  add_foreign_key "proofs", "insights"
end
