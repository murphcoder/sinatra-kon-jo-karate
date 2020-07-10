# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_09_203905) do

  create_table "instructors", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.string "description"
    t.string "cell_phone"
    t.string "email"
    t.boolean "admin?"
    t.string "recovery"
  end

  create_table "lesson_instructors", force: :cascade do |t|
    t.integer "lesson_id"
    t.integer "instructor_id"
    t.index ["instructor_id"], name: "index_lesson_instructors_on_instructor_id"
    t.index ["lesson_id"], name: "index_lesson_instructors_on_lesson_id"
  end

  create_table "lesson_students", force: :cascade do |t|
    t.integer "lesson_id"
    t.integer "student_id"
    t.index ["lesson_id"], name: "index_lesson_students_on_lesson_id"
    t.index ["student_id"], name: "index_lesson_students_on_student_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.integer "location_id"
    t.time "start_time"
    t.time "end_time"
    t.date "start_date"
    t.date "end_date"
    t.integer "price"
    t.index ["location_id"], name: "index_lessons_on_location_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "address"
  end

  create_table "parents", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "address"
    t.string "password_digest"
    t.string "cell_phone"
    t.integer "balance"
    t.string "recovery"
  end

  create_table "students", force: :cascade do |t|
    t.integer "parent_id"
    t.string "name"
    t.index ["parent_id"], name: "index_students_on_parent_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "lesson_id"
    t.integer "student_id"
    t.integer "cost"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "paid?"
    t.index ["lesson_id"], name: "index_transactions_on_lesson_id"
    t.index ["student_id"], name: "index_transactions_on_student_id"
  end

end
