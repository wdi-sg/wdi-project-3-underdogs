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

ActiveRecord::Schema.define(version: 20170505092707) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "Rewards_Users", id: false, force: :cascade do |t|
    t.integer "user_id",   null: false
    t.integer "reward_id", null: false
  end

  create_table "bank_account_infos", force: :cascade do |t|
    t.string   "bank_name"
    t.string   "bank_currency"
    t.integer  "account_no"
    t.string   "name_on_account"
    t.string   "branch_code"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["user_id"], name: "index_bank_account_infos_on_user_id", using: :btree
  end

  create_table "incomes", force: :cascade do |t|
    t.integer  "monthly_income"
    t.integer  "monthly_savings_goal"
    t.integer  "final_savings_goal"
    t.integer  "user_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["user_id"], name: "index_incomes_on_user_id", using: :btree
  end

  create_table "rewards", force: :cascade do |t|
    t.string  "merchant"
    t.string  "merchant_code"
    t.string  "item"
    t.integer "value"
    t.string  "expiry"
    t.string  "category"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "transacted_amount"
    t.date     "transacted_date"
    t.integer  "transaction_no"
    t.integer  "user_id"
    t.integer  "bank_account_info_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["bank_account_info_id"], name: "index_transactions_on_bank_account_info_id", using: :btree
    t.index ["user_id"], name: "index_transactions_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "id_no"
    t.string   "dob"
    t.string   "gender"
    t.string   "nationality"
    t.string   "address"
    t.string   "country"
    t.string   "postal_code"
    t.integer  "mobile_no"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
