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

ActiveRecord::Schema[7.1].define(version: 2025_03_03_213600) do
  create_table "playoffs", force: :cascade do |t|
    t.integer "round"
    t.integer "player_1_id"
    t.integer "player_2_id"
    t.integer "winner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "player_1_seed"
    t.integer "player_2_seed"
  end

  create_table "rounds", force: :cascade do |t|
    t.integer "round_number"
    t.string "course"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "score_id"
    t.index ["score_id"], name: "index_rounds_on_score_id"
  end

  create_table "scores", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "round_id"
    t.integer "score"
    t.date "date_played"
    t.integer "user_id"
    t.integer "net_score"
    t.decimal "points", precision: 4, scale: 1
    t.index ["user_id"], name: "index_scores_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "handicap"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "rounds", "scores"
  add_foreign_key "scores", "users", on_delete: :cascade
end
