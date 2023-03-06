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

ActiveRecord::Schema[7.0].define(version: 2023_03_06_180832) do
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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "dietary_information_recipes", force: :cascade do |t|
    t.bigint "dietary_information_id", null: false
    t.bigint "recipe_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dietary_information_id"], name: "index_dietary_information_recipes_on_dietary_information_id"
    t.index ["recipe_id"], name: "index_dietary_information_recipes_on_recipe_id"
  end

  create_table "dietary_information_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "dietary_information_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dietary_information_id"], name: "index_dietary_information_users_on_dietary_information_id"
    t.index ["user_id"], name: "index_dietary_information_users_on_user_id"
  end

  create_table "dietary_informations", force: :cascade do |t|
    t.string "name"
    t.string "allergy"
    t.string "intolerance"
    t.string "preference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favourite_recipes", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_favourite_recipes_on_recipe_id"
    t.index ["user_id"], name: "index_favourite_recipes_on_user_id"
  end

  create_table "fridge_ingredients", force: :cascade do |t|
    t.bigint "ingredient_id", null: false
    t.bigint "fridge_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fridge_id"], name: "index_fridge_ingredients_on_fridge_id"
    t.index ["ingredient_id"], name: "index_fridge_ingredients_on_ingredient_id"
  end

  create_table "fridges", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_fridges_on_user_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "nutriscore"
    t.string "name"
    t.date "expiry_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "list_ingredients", force: :cascade do |t|
    t.bigint "ingredient_id", null: false
    t.bigint "list_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_list_ingredients_on_ingredient_id"
    t.index ["list_id"], name: "index_list_ingredients_on_list_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "recipe_ingredients", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "ingredient_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_recipe_ingredients_on_ingredient_id"
    t.index ["recipe_id"], name: "index_recipe_ingredients_on_recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.time "prep_time"
    t.string "instruction"
    t.integer "difficulty"
    t.string "utensil"
    t.string "title"
    t.time "cooking_time"
    t.time "total_time"
    t.integer "serving"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "user_id", null: false
    t.integer "rating"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_reviews_on_recipe_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "to_do_recipes", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_to_do_recipes_on_recipe_id"
    t.index ["user_id"], name: "index_to_do_recipes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "dietary_information_recipes", "dietary_informations"
  add_foreign_key "dietary_information_recipes", "recipes"
  add_foreign_key "dietary_information_users", "dietary_informations"
  add_foreign_key "dietary_information_users", "users"
  add_foreign_key "favourite_recipes", "recipes"
  add_foreign_key "favourite_recipes", "users"
  add_foreign_key "fridge_ingredients", "fridges"
  add_foreign_key "fridge_ingredients", "ingredients"
  add_foreign_key "fridges", "users"
  add_foreign_key "list_ingredients", "ingredients"
  add_foreign_key "list_ingredients", "lists"
  add_foreign_key "lists", "users"
  add_foreign_key "recipe_ingredients", "ingredients"
  add_foreign_key "recipe_ingredients", "recipes"
  add_foreign_key "recipes", "users"
  add_foreign_key "reviews", "recipes"
  add_foreign_key "reviews", "users"
  add_foreign_key "to_do_recipes", "recipes"
  add_foreign_key "to_do_recipes", "users"
end
