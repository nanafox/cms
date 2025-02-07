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

ActiveRecord::Schema[8.0].define(version: 2025_02_06_170619) do
  create_table "church_management_chapels", force: :cascade do |t|
    t.string "name", null: false
    t.string "color", null: false
    t.integer "quarter", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "church_management_members", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "middle_name"
    t.date "date_of_birth", null: false
    t.integer "marital_status", null: false
    t.string "email_address"
    t.string "residential_address", null: false
    t.string "primary_phone_number", null: false
    t.string "whatsapp_account_number"
    t.integer "employment_status", null: false
    t.integer "creator_id", null: false
    t.integer "chapel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chapel_id"], name: "index_church_management_members_on_chapel_id"
    t.index ["creator_id"], name: "index_church_management_members_on_creator_id"
  end

  create_table "church_management_ministries", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "church_management_ministry_memberships", force: :cascade do |t|
    t.integer "role", null: false
    t.integer "member_id", null: false
    t.integer "ministry_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_church_management_ministry_memberships_on_member_id"
    t.index ["ministry_id", "member_id"], name: "idx_on_ministry_id_member_id_dc050155b3", unique: true
    t.index ["ministry_id"], name: "index_church_management_ministry_memberships_on_ministry_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name", null: false
    t.integer "user_id", null: false
    t.integer "chapel_id", null: false
    t.string "phone_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chapel_id"], name: "index_profiles_on_chapel_id"
    t.index ["user_id"], name: "index_profiles_on_user_id", unique: true
  end

  create_table "user_login_change_keys", force: :cascade do |t|
    t.string "key", null: false
    t.string "login", null: false
    t.datetime "deadline", null: false
  end

  create_table "user_password_reset_keys", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "deadline", null: false
    t.datetime "email_last_sent", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "user_remember_keys", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "deadline", null: false
  end

  create_table "user_verification_keys", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "requested_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "email_last_sent", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer "status", default: 1, null: false
    t.string "email", null: false
    t.integer "role"
    t.string "password_hash"
    t.index ["email"], name: "index_users_on_email", unique: true, where: "status IN (1, 2)"
  end

  add_foreign_key "church_management_members", "church_management_chapels", column: "chapel_id"
  add_foreign_key "church_management_members", "users", column: "creator_id"
  add_foreign_key "church_management_ministry_memberships", "church_management_members", column: "member_id"
  add_foreign_key "church_management_ministry_memberships", "church_management_ministries", column: "ministry_id"
  add_foreign_key "profiles", "church_management_chapels", column: "chapel_id"
  add_foreign_key "profiles", "users"
  add_foreign_key "user_login_change_keys", "users", column: "id"
  add_foreign_key "user_password_reset_keys", "users", column: "id"
  add_foreign_key "user_remember_keys", "users", column: "id"
  add_foreign_key "user_verification_keys", "users", column: "id"
end
