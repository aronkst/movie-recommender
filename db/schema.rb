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

ActiveRecord::Schema[7.0].define(version: 2022_09_06_010507) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "invalid_movies", force: :cascade do |t|
    t.string "imdb", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imdb"], name: "index_invalid_movies_on_imdb", unique: true
  end

  create_table "movies", force: :cascade do |t|
    t.string "imdb", null: false
    t.string "title", null: false
    t.integer "year", null: false
    t.string "summary", null: false
    t.float "score", null: false
    t.integer "amount_of_votes", null: false
    t.integer "metascore", null: false
    t.integer "points", null: false
    t.string "genres", default: [], null: false, array: true
    t.string "recommended_movies", default: [], null: false, array: true
    t.string "url_cover", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imdb"], name: "index_movies_on_imdb", unique: true
  end

  create_table "states", force: :cascade do |t|
    t.string "imdb", null: false
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imdb"], name: "index_states_on_imdb", unique: true
  end

end
