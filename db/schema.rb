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

ActiveRecord::Schema.define(version: 2020_07_17_144759) do

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

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "discounts", force: :cascade do |t|
    t.string "name"
    t.integer "percentage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name"
    t.integer "sport"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sequence"
  end

  create_table "package_discounts", force: :cascade do |t|
    t.integer "package_id"
    t.integer "discount_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "packages", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.integer "currency"
    t.string "symbol"
    t.text "paypal_url", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "capacity", default: 1
    t.boolean "show", default: false
    t.jsonb "available", default: {}
    t.integer "max_capacity", default: 1
    t.integer "discount_id"
    t.boolean "require_discount", default: false
    t.boolean "show_price", default: true
  end

  create_table "purchases", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone_number"
    t.string "address_line1"
    t.string "address_line2"
    t.integer "package_id", null: false
    t.integer "team_id", null: false
    t.integer "status", default: 0
    t.string "payer_id", default: ""
    t.string "order_id", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price_at_purchase", default: "0.0"
    t.string "tracking_number"
    t.integer "delivery", default: 0
    t.integer "capacity"
    t.integer "discount_id"
    t.float "discount_value"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.integer "league_id"
    t.jsonb "packages", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "send_registration_email", default: true
    t.text "payment_email_text", default: ""
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "team_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
