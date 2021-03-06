# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_30_211321) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "argument_parent_child_relationships", force: :cascade do |t|
    t.bigint "child_id", null: false
    t.bigint "parent_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["child_id"], name: "index_argument_parent_child_relationships_on_child_id"
    t.index ["parent_id"], name: "index_argument_parent_child_relationships_on_parent_id"
  end

  create_table "arguments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "content"
    t.string "source"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "hidden"
    t.index ["user_id"], name: "index_arguments_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.text "message"
    t.bigint "user_id", null: false
    t.boolean "read", default: false
    t.bigint "argument_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["argument_id"], name: "index_notifications_on_argument_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tags_arguments", force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "argument_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["argument_id"], name: "index_tags_arguments_on_argument_id"
    t.index ["tag_id"], name: "index_tags_arguments_on_tag_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "nickname"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.string "category"
    t.boolean "positive"
    t.bigint "user_id", null: false
    t.bigint "argument_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["argument_id"], name: "index_votes_on_argument_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "argument_parent_child_relationships", "arguments", column: "child_id"
  add_foreign_key "argument_parent_child_relationships", "arguments", column: "parent_id"
  add_foreign_key "arguments", "users"
  add_foreign_key "notifications", "arguments"
  add_foreign_key "notifications", "users"
  add_foreign_key "tags_arguments", "arguments"
  add_foreign_key "tags_arguments", "tags"
  add_foreign_key "votes", "arguments"
  add_foreign_key "votes", "users"
end
