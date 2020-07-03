class LessonInstructors < ActiveRecord::Migration[6.0]
  def change
    create_table :lesson_instructors do |t|
      t.belongs_to :lesson
      t.belongs_to :instructor
    end
  end
end
