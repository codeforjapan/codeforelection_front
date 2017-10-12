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

ActiveRecord::Schema.define(version: 20171012145021) do

  create_table "candidates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name_first", null: false
    t.string "name_last", null: false
    t.string "name_first_furigana"
    t.string "name_last_furigana"
    t.integer "party_id"
    t.integer "senkyoku_id"
    t.integer "gender"
    t.date "birth_day"
    t.integer "birth_year"
    t.string "twitter_id"
    t.string "facebook_id"
    t.string "official_website_url"
    t.string "photo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "wikidata_id"
    t.boolean "is_candidate"
    t.integer "current_position"
    t.integer "submission_order"
    t.string "winning_history"
    t.integer "hirei_area_id"
    t.index ["wikidata_id"], name: "index_candidates_on_wikidata_id", unique: true
  end

  create_table "cities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "city_code", null: false
    t.string "pref_code", null: false
    t.string "city_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_code"], name: "index_cities_on_city_code", unique: true
  end

  create_table "hirei_senkyokus", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hirei_senkyokus_prefs", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "pref_id", null: false
    t.bigint "hirei_senkyoku_id", null: false
  end

  create_table "parties", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "short_name", null: false
    t.string "full_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prefs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "pref_code", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pref_code"], name: "index_prefs_on_pref_code"
  end

  create_table "senkyokus", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "pref_code", null: false
    t.integer "senkyoku_no", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pref_code", "senkyoku_no"], name: "index_senkyokus_on_pref_code_and_senkyoku_no", unique: true
  end

  create_table "senkyokus_zip_codes", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "senkyoku_id", null: false
    t.bigint "zip_code_id", null: false
  end

  create_table "zip_codes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "zip_code", null: false
    t.integer "city_id"
    t.index ["zip_code"], name: "index_zip_codes_on_zip_code", unique: true
  end

end
