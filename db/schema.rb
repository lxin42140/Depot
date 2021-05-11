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

ActiveRecord::Schema.define(version: 2021_05_11_062521) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "products", force: :cascade do |t|
    t.integer "product_id"
    t.string "name"
    t.text "description"
    t.decimal "unit_price", precision: 8, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sale_transaction_line_items", force: :cascade do |t|
    t.integer "item_id"
    t.integer "quantity"
    t.decimal "subtotal", precision: 8, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sale_transaction_id"
    t.integer "product_id"
  end

  create_table "sale_transactions", force: :cascade do |t|
    t.integer "transaction_id"
    t.integer "total_line_item"
    t.integer "total_quantity"
    t.decimal "total_amount", precision: 8, scale: 2
    t.date "transaction_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "integer"
    t.integer "user_id"
  end

  create_table "staff_logs", force: :cascade do |t|
    t.integer "log_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "product_id"
    t.integer "staff_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "user_id"
    t.string "first_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.string "username"
    t.integer "access_right_enum"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "type"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "password_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "sale_transaction_line_items", "products", name: "sale_transaction_line_items_product_id_fkey"
  add_foreign_key "sale_transaction_line_items", "sale_transactions", name: "sale_transaction_line_items_sale_transaction_id_fkey"
  add_foreign_key "sale_transactions", "users", name: "sale_transactions_user_id_fkey"
  add_foreign_key "staff_logs", "products", name: "staff_logs_product_id_fkey"
  add_foreign_key "staff_logs", "users", column: "staff_id", name: "staff_logs_staff_id_fkey"
end
