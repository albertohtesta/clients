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

ActiveRecord::Schema[7.0].define(version: 2022_06_17_183337) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_statuses", force: :cascade do |t|
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["account_status_id"], name: "index_accounts_on_account_status_id"
  end

  create_table "app_connections", force: :cascade do |t|
    t.string "name", null: false
    t.string "api_token", null: false
    t.string "secret_token_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "colaborators", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "uuid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "collaborators", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "payments", force: :cascade do |t|
    t.datetime "payment_date"
    t.date "cut_off_date", null: false
    t.date "payday_limit", null: false
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_payments_on_account_id"
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
    t.index ["account_id"], name: "index_projects_on_account_id"
  end

  create_table "projects_teams", id: false, force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "team_id", null: false
    t.index ["project_id", "team_id"], name: "index_projects_teams_on_project_id_and_team_id"
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

  add_foreign_key "accounts", "account_statuses"
  add_foreign_key "payments", "accounts"
  add_foreign_key "projects", "accounts"
  add_foreign_key "teams", "team_types"
end
