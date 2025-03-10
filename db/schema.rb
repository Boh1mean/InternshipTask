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

ActiveRecord::Schema[8.0].define(version: 2025_03_10_135158) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "auth_tokens", force: :cascade do |t|
    t.string "bearer", null: false
    t.bigint "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bearer"], name: "index_auth_tokens_on_bearer", unique: true
    t.index ["student_id"], name: "index_auth_tokens_on_student_id"
  end

  create_table "school_classes", force: :cascade do |t|
    t.integer "number", null: false
    t.string "letter", null: false
    t.integer "students_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "school_id", null: false
    t.index ["school_id"], name: "index_school_classes_on_school_id"
    t.index ["students_count"], name: "index_school_classes_on_students_count"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "surname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "school_class_id", null: false
    t.bigint "school_id", null: false
    t.index ["school_class_id"], name: "index_students_on_school_class_id"
    t.index ["school_id"], name: "index_students_on_school_id"
  end

  add_foreign_key "auth_tokens", "students"
  add_foreign_key "school_classes", "schools"
  add_foreign_key "students", "school_classes"
  add_foreign_key "students", "schools"
end
