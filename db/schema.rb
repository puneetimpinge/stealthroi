# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151013112809) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "ad_keywords", force: :cascade do |t|
    t.string   "group_id",      limit: 255
    t.string   "campaign_id",   limit: 255
    t.string   "target_domain", limit: 255
    t.string   "target_page",   limit: 255
    t.string   "name",          limit: 255
    t.float    "ctr",           limit: 24
    t.float    "cpm",           limit: 24
    t.float    "cpc",           limit: 24
    t.float    "totalspend",    limit: 24
    t.integer  "conversions",   limit: 4
    t.integer  "user_id",       limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "ad_keywords", ["user_id"], name: "index_ad_keywords_on_user_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "fname",                  limit: 255
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "campaign_stats", force: :cascade do |t|
    t.string   "campaign_name",       limit: 255
    t.integer  "current_order_count", limit: 4
    t.string   "current_item_count",  limit: 255
    t.integer  "total_sales_amount",  limit: 4
    t.float    "profit",              limit: 24
    t.integer  "total_visits",        limit: 4
    t.string   "urlcode",             limit: 255
    t.integer  "campaign_id",         limit: 4
    t.integer  "user_id",             limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "campaign_stats", ["user_id"], name: "index_campaign_stats_on_user_id", using: :btree

  create_table "card_transactions", force: :cascade do |t|
    t.integer  "card_id",       limit: 4
    t.string   "action",        limit: 255
    t.integer  "amount",        limit: 4
    t.boolean  "success",       limit: 1
    t.string   "authorization", limit: 255
    t.string   "message",       limit: 255
    t.text     "params",        limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "card_transactions", ["card_id"], name: "index_card_transactions_on_card_id", using: :btree

  create_table "cards", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.string   "ip_address",      limit: 255
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "card_type",       limit: 255
    t.date     "card_expires_on"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "cards", ["user_id"], name: "index_cards_on_user_id", using: :btree

  create_table "fb_ads", force: :cascade do |t|
    t.string   "adid",       limit: 255
    t.string   "urlcode",    limit: 255
    t.string   "urldomain",  limit: 255
    t.float    "t_spend",    limit: 24
    t.float    "tot_spend",  limit: 24
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "fbauthtokens", force: :cascade do |t|
    t.string   "email",      limit: 255
    t.string   "fbtoken",    limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string   "notification_text",   limit: 255
    t.integer  "notification_unread", limit: 4
    t.integer  "user_id",             limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.string   "first_name",     limit: 255
    t.string   "last_name",      limit: 255
    t.integer  "amount",         limit: 4
    t.string   "transaction_id", limit: 255
    t.integer  "user_id",        limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "payments", ["user_id"], name: "index_payments_on_user_id", using: :btree

  create_table "shopify_stats", force: :cascade do |t|
    t.integer  "order",        limit: 4
    t.string   "created_time", limit: 255
    t.float    "price",        limit: 24
    t.integer  "user_id",      limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "shopify_stats", ["user_id"], name: "index_shopify_stats_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",      null: false
    t.string   "passwordhash",           limit: 255, default: "",      null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.integer  "accesslevel",            limit: 4
    t.string   "viralstyleapikey",       limit: 255
    t.string   "fname",                  limit: 255
    t.string   "emailverificationcode",  limit: 255
    t.string   "tableprefix",            limit: 255
    t.string   "timezonecode",           limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "payment_status",         limit: 255, default: "false"
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "phone",                  limit: 255
    t.string   "avatar",                 limit: 255
    t.string   "fbadaccount",            limit: 255
    t.string   "timezone",               limit: 255
    t.string   "shopify",                limit: 255
    t.string   "teechip",                limit: 255
    t.string   "teespring",              limit: 255
    t.string   "represent",              limit: 255
    t.string   "shopify_password",       limit: 255
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "ad_keywords", "users"
  add_foreign_key "campaign_stats", "users"
  add_foreign_key "card_transactions", "cards"
  add_foreign_key "cards", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "payments", "users"
end
