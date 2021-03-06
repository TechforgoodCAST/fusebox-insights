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

ActiveRecord::Schema.define(version: 2020_03_13_111430) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "ahoy_events", force: :cascade do |t|
    t.bigint "visit_id"
    t.bigint "user_id"
    t.string "name"
    t.jsonb "properties"
    t.datetime "time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["properties"], name: "index_ahoy_events_on_properties", opclass: :jsonb_path_ops, using: :gin
    t.index ["user_id"], name: "index_ahoy_events_on_user_id"
    t.index ["visit_id"], name: "index_ahoy_events_on_visit_id"
  end

  create_table "ahoy_messages", force: :cascade do |t|
    t.string "user_type"
    t.bigint "user_id"
    t.text "to"
    t.string "mailer"
    t.text "subject"
    t.datetime "sent_at"
    t.index ["user_type", "user_id"], name: "index_ahoy_messages_on_user_type_and_user_id"
  end

  create_table "ahoy_visits", force: :cascade do |t|
    t.string "visit_token"
    t.string "visitor_token"
    t.bigint "user_id"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.string "referring_domain"
    t.text "landing_page"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.string "country"
    t.string "region"
    t.string "city"
    t.float "latitude"
    t.float "longitude"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.string "app_version"
    t.string "os_version"
    t.string "platform"
    t.datetime "started_at"
    t.index ["user_id"], name: "index_ahoy_visits_on_user_id"
    t.index ["visit_token"], name: "index_ahoy_visits_on_visit_token", unique: true
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

  create_table "check_in_ratings", force: :cascade do |t|
    t.integer "score"
    t.text "comments"
    t.bigint "check_in_id", null: false
    t.bigint "outcome_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["check_in_id"], name: "index_check_in_ratings_on_check_in_id"
    t.index ["outcome_id"], name: "index_check_in_ratings_on_outcome_id"
  end

  create_table "check_ins", force: :cascade do |t|
    t.text "notes"
    t.bigint "completed_by", null: false
    t.bigint "iteration_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.index ["iteration_id"], name: "index_check_ins_on_iteration_id"
  end

  create_table "cohorts", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cohorts_offers", id: false, force: :cascade do |t|
    t.bigint "cohort_id", null: false
    t.bigint "offer_id", null: false
  end

  create_table "debrief_ratings", force: :cascade do |t|
    t.integer "score"
    t.text "comments"
    t.bigint "debrief_id", null: false
    t.bigint "outcome_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["debrief_id"], name: "index_debrief_ratings_on_debrief_id"
    t.index ["outcome_id"], name: "index_debrief_ratings_on_outcome_id"
  end

  create_table "debriefs", force: :cascade do |t|
    t.text "notes"
    t.bigint "completed_by", null: false
    t.boolean "milestone_completed"
    t.bigint "milestone_id", null: false
    t.bigint "iteration_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["iteration_id"], name: "index_debriefs_on_iteration_id"
    t.index ["milestone_id"], name: "index_debriefs_on_milestone_id"
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

  create_table "iterations", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.date "start_date"
    t.date "planned_debrief_date"
    t.integer "status", default: 0, null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_check_in_at"
    t.date "actual_debrief_date"
    t.index ["project_id"], name: "index_iterations_on_project_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0, null: false
    t.index ["project_id", "user_id"], name: "index_memberships_on_project_id_and_user_id", unique: true
    t.index ["project_id"], name: "index_memberships_on_project_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "milestones", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.text "success_criteria"
    t.datetime "completed_at"
    t.date "deadline"
    t.integer "status", default: 0, null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_milestones_on_project_id"
  end

  create_table "offers", force: :cascade do |t|
    t.bigint "provider_id"
    t.string "title", null: false
    t.text "short_description"
    t.text "long_description"
    t.string "sign_up_link"
    t.string "logo_link"
    t.integer "duration_category"
    t.string "duration_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider_email"
    t.index ["provider_id"], name: "index_offers_on_provider_id"
  end

  create_table "offers_topics", id: false, force: :cascade do |t|
    t.bigint "topic_id", null: false
    t.bigint "offer_id", null: false
  end

  create_table "outcomes", force: :cascade do |t|
    t.text "title", null: false
    t.text "success_criteria"
    t.bigint "iteration_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["iteration_id"], name: "index_outcomes_on_iteration_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.text "more_details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cohort_id"
  end

  create_table "providers", force: :cascade do |t|
    t.string "name", null: false
    t.string "website", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "support_requests", force: :cascade do |t|
    t.bigint "requester_id"
    t.bigint "on_behalf_of_id"
    t.text "message"
    t.bigint "offer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "project_id"
    t.index ["offer_id"], name: "index_support_requests_on_offer_id"
    t.index ["on_behalf_of_id"], name: "index_support_requests_on_on_behalf_of_id"
    t.index ["requester_id"], name: "index_support_requests_on_requester_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "title"
    t.text "short_desc"
    t.text "long_desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "display_name"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.boolean "is_admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "check_in_ratings", "check_ins"
  add_foreign_key "check_in_ratings", "outcomes"
  add_foreign_key "check_ins", "iterations"
  add_foreign_key "debrief_ratings", "debriefs"
  add_foreign_key "debrief_ratings", "outcomes"
  add_foreign_key "debriefs", "iterations"
  add_foreign_key "debriefs", "milestones"
  add_foreign_key "iterations", "projects"
  add_foreign_key "milestones", "projects"
  add_foreign_key "offers", "providers"
  add_foreign_key "outcomes", "iterations"
  add_foreign_key "projects", "cohorts"
  add_foreign_key "support_requests", "offers"
  add_foreign_key "support_requests", "projects"
  add_foreign_key "support_requests", "users", column: "on_behalf_of_id"
  add_foreign_key "support_requests", "users", column: "requester_id"
end
