# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_08_03_230130) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_contact_collaborators", id: false, force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "collaborator_id"
    t.index ["account_id"], name: "index_account_contact_collaborators_on_account_id"
    t.index ["collaborator_id"], name: "index_account_contact_collaborators_on_collaborator_id"
  end

  create_table "account_follow_ups", force: :cascade do |t|
    t.date "follow_date"
    t.string "description"
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_follow_ups_on_account_id"
  end

  create_table "account_statuses", force: :cascade do |t|
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status_code"
    t.index ["status_code"], name: "index_account_statuses_on_status_code", unique: true
  end

  create_table "accounts", force: :cascade do |t|
    t.string "account_uuid", null: false
    t.string "name", null: false
    t.string "contact_name"
    t.string "contact_email"
    t.string "contact_phone"
    t.string "account_web_page"
    t.string "service_duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_status_id", null: false
    t.bigint "manager_id"
    t.string "country"
    t.string "state"
    t.string "city"
    t.string "salesforce_id", default: "0", null: false
    t.integer "balance", default: 0
    t.decimal "blended_rate", default: "0.0"
    t.decimal "gross_profit", default: "0.0"
    t.decimal "payroll", default: "0.0"
    t.decimal "total_expenses", default: "0.0"
    t.decimal "total_revenue", default: "0.0"
    t.integer "client_satisfaction", default: 0
    t.integer "moral", default: 0
    t.integer "bugs_detected", default: 0
    t.integer "permanence", default: 0
    t.integer "productivity", default: 0
    t.integer "speed", default: 0
    t.datetime "deleted_at", precision: nil
    t.index ["account_status_id"], name: "index_accounts_on_account_status_id"
    t.index ["manager_id"], name: "index_accounts_on_manager_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "app_connections", force: :cascade do |t|
    t.string "name", null: false
    t.string "api_name", null: false
    t.string "secret_token_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "badges", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "collaborators", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "email", null: false
    t.string "uuid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "role_id", null: false
    t.string "last_name"
    t.string "position"
    t.string "profile"
    t.string "seniority"
    t.string "english_level"
    t.text "about"
    t.string "work_modality"
    t.string "phone"
    t.index ["role_id"], name: "index_collaborators_on_role_id"
  end

  create_table "collaborators_badges", force: :cascade do |t|
    t.bigint "collaborator_id", null: false
    t.bigint "badge_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["badge_id"], name: "index_collaborators_badges_on_badge_id"
    t.index ["collaborator_id"], name: "index_collaborators_badges_on_collaborator_id"
  end

  create_table "collaborators_teams", id: false, force: :cascade do |t|
    t.bigint "collaborator_id", null: false
    t.bigint "team_id", null: false
    t.index ["collaborator_id", "team_id"], name: "index_collaborators_teams_on_collaborator_id_and_team_id"
  end

  create_table "collaborators_tech_stacks", id: false, force: :cascade do |t|
    t.bigint "collaborator_id", null: false
    t.bigint "tech_stack_id", null: false
    t.index ["collaborator_id", "tech_stack_id"], name: "index_collaborators_tech_stacks_on_colaborator_and_tech_stack"
  end

  create_table "collaborators_tools", id: false, force: :cascade do |t|
    t.bigint "collaborator_id", null: false
    t.bigint "tool_id", null: false
    t.index ["collaborator_id", "tool_id"], name: "index_collaborators_tools_on_collaborator_id_and_tool_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "salesforce_id"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.bigint "account_id", null: false
    t.datetime "deleted_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_contacts_on_account_id"
  end

  create_table "investments", force: :cascade do |t|
    t.bigint "team_id"
    t.float "value", default: 0.0
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_investments_on_date"
    t.index ["team_id"], name: "index_investments_on_team_id"
  end

  create_table "metrics", force: :cascade do |t|
    t.text "metrics", null: false
    t.string "indicator_type", null: false
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "related_type"
    t.bigint "related_id"
    t.index ["related_type", "related_id"], name: "index_metrics_on_related"
  end

  create_table "payments", force: :cascade do |t|
    t.datetime "payment_date"
    t.date "cut_off_date", null: false
    t.date "payday_limit", null: false
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_payments_on_account_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "collaborator_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collaborator_id"], name: "index_posts_on_collaborator_id"
    t.index ["project_id"], name: "index_posts_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name", null: false
    t.date "start_date", null: false
    t.date "end_date"
    t.string "description"
    t.date "delivery_dates"
    t.date "demo_dates"
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "salesforce_id"
    t.datetime "deleted_at", precision: nil
    t.index ["account_id"], name: "index_projects_on_account_id"
  end

  create_table "projects_tech_stacks", id: false, force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "tech_stack_id", null: false
    t.index ["project_id", "tech_stack_id"], name: "index_projects_tech_stacks_on_project_id_and_tech_stack_id"
  end

  create_table "projects_tools", id: false, force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "tool_id", null: false
    t.index ["project_id", "tool_id"], name: "index_projects_tools_on_project_id_and_tool_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "team_requirements", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "team_id", null: false
    t.bigint "collaborator_id"
    t.bigint "role_id", null: false
    t.string "seniority", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_team_requirements_on_account_id"
    t.index ["collaborator_id"], name: "index_team_requirements_on_collaborator_id"
    t.index ["role_id"], name: "index_team_requirements_on_role_id"
    t.index ["team_id"], name: "index_team_requirements_on_team_id"
  end

  create_table "team_requirements_tech_stacks", force: :cascade do |t|
    t.bigint "team_requirement_id"
    t.bigint "tech_stack_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_requirement_id"], name: "index_team_requirements_tech_stacks_on_team_requirement_id"
    t.index ["tech_stack_id"], name: "index_team_requirements_tech_stacks_on_tech_stack_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.integer "status"
    t.string "survey_url"
    t.integer "requested_answers"
    t.integer "current_answers"
    t.date "deadline"
    t.integer "period"
    t.jsonb "questions_detail"
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "answers_detail"
    t.index ["answers_detail"], name: "index_surveys_on_answers_detail", using: :gin
    t.index ["period"], name: "index_surveys_on_period"
    t.index ["questions_detail"], name: "index_surveys_on_questions_detail", using: :gin
    t.index ["team_id"], name: "index_surveys_on_team_id"
  end

  create_table "team_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.datetime "added_date", null: false
    t.bigint "team_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "project_id"
    t.index ["project_id"], name: "index_teams_on_project_id"
    t.index ["team_type_id"], name: "index_teams_on_team_type_id"
  end

  create_table "tech_stacks", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tools", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "account_follow_ups", "accounts"
  add_foreign_key "accounts", "account_statuses"
  add_foreign_key "accounts", "collaborators", column: "manager_id"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "collaborators", "roles"
  add_foreign_key "collaborators_badges", "badges"
  add_foreign_key "collaborators_badges", "collaborators"
  add_foreign_key "contacts", "accounts"
  add_foreign_key "investments", "teams"
  add_foreign_key "payments", "accounts"
  add_foreign_key "posts", "collaborators"
  add_foreign_key "posts", "projects"
  add_foreign_key "projects", "accounts"
  add_foreign_key "team_requirements", "accounts"
  add_foreign_key "team_requirements", "collaborators"
  add_foreign_key "team_requirements", "roles"
  add_foreign_key "team_requirements", "teams"
  add_foreign_key "surveys", "teams"
  add_foreign_key "teams", "projects"
  add_foreign_key "teams", "team_types"
end
