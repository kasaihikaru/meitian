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

ActiveRecord::Schema.define(version: 2022_03_12_135706) do

  create_table "p_words", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "passage_id"
    t.text "ja"
    t.text "ch"
    t.text "pin"
    t.boolean "memorized_ja", default: false, null: false
    t.boolean "memorized_ch", default: false, null: false
    t.boolean "pin_fixed", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["passage_id"], name: "index_p_words_on_passage_id"
  end

  create_table "papers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.datetime "modified_at"
    t.integer "original_id"
    t.boolean "sample", default: false, null: false
    t.integer "status", limit: 1, default: 0
    t.index ["user_id"], name: "index_papers_on_user_id"
  end

  create_table "passages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title", null: false
    t.text "ja"
    t.text "ch"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.datetime "modified_at"
    t.integer "original_id"
    t.boolean "sample", default: false, null: false
    t.integer "status", limit: 1, default: 0
    t.index ["user_id"], name: "index_passages_on_user_id"
  end

  create_table "r_words", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "ring_id"
    t.text "ja"
    t.text "ch"
    t.text "pin"
    t.boolean "memorized_ja", default: false, null: false
    t.boolean "memorized_ch", default: false, null: false
    t.boolean "pin_fixed", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["ring_id"], name: "index_r_words_on_ring_id"
  end

  create_table "rings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.datetime "modified_at"
    t.integer "original_id"
    t.boolean "sample", default: false, null: false
    t.integer "status", limit: 1, default: 0
    t.index ["user_id"], name: "index_rings_on_user_id"
  end

  create_table "s_words", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "sentence_id"
    t.text "ja"
    t.text "ch"
    t.text "pin"
    t.boolean "memorized_ja", default: false, null: false
    t.boolean "memorized_ch", default: false, null: false
    t.boolean "pin_fixed", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["sentence_id"], name: "index_s_words_on_sentence_id"
  end

  create_table "sample_p_words", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "ja"
    t.text "ch"
    t.text "pin"
    t.datetime "deleted_at"
    t.bigint "sample_passage_id"
    t.index ["sample_passage_id"], name: "index_sample_p_words_on_sample_passage_id"
  end

  create_table "sample_papers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "level", limit: 1, default: 0
    t.string "name", null: false
    t.datetime "deleted_at"
  end

  create_table "sample_passages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "level", limit: 1, default: 0
    t.string "title", null: false
    t.text "ja"
    t.text "ch"
    t.datetime "deleted_at"
  end

  create_table "sample_r_words", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "ja"
    t.text "ch"
    t.text "pin"
    t.datetime "deleted_at"
    t.bigint "sample_ring_id"
    t.index ["sample_ring_id"], name: "index_sample_r_words_on_sample_ring_id"
  end

  create_table "sample_rings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "level", limit: 1, default: 0
    t.string "name", null: false
    t.datetime "deleted_at"
  end

  create_table "sample_s_words", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "ja"
    t.text "ch"
    t.text "pin"
    t.datetime "deleted_at"
    t.bigint "sample_sentence_id"
    t.index ["sample_sentence_id"], name: "index_sample_s_words_on_sample_sentence_id"
  end

  create_table "sample_sentences", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "ja"
    t.text "ch"
    t.text "pin"
    t.datetime "deleted_at"
    t.bigint "sample_paper_id"
    t.index ["sample_paper_id"], name: "index_sample_sentences_on_sample_paper_id"
  end

  create_table "sentences", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "paper_id"
    t.text "ja"
    t.text "ch"
    t.text "pin"
    t.boolean "memorized_ja", default: false, null: false
    t.boolean "memorized_ch", default: false, null: false
    t.boolean "pin_fixed", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.integer "original_id"
    t.boolean "sample", default: false, null: false
    t.index ["paper_id"], name: "index_sentences_on_paper_id"
  end

  create_table "themes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.text "theme"
    t.date "yearmonth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_themes_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.text "goal"
    t.text "introduction"
    t.text "link"
    t.datetime "deleted_at"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "level", limit: 1, default: 0
    t.integer "icon", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "p_words", "passages"
  add_foreign_key "papers", "users"
  add_foreign_key "passages", "users"
  add_foreign_key "r_words", "rings"
  add_foreign_key "rings", "users"
  add_foreign_key "s_words", "sentences"
  add_foreign_key "sample_p_words", "sample_passages"
  add_foreign_key "sample_r_words", "sample_rings"
  add_foreign_key "sample_s_words", "sample_sentences"
  add_foreign_key "sample_sentences", "sample_papers"
  add_foreign_key "sentences", "papers"
  add_foreign_key "themes", "users"
end
