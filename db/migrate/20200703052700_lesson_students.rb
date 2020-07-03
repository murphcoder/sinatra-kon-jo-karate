class LessonStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :lesson_students do |t|
      t.belongs_to :lesson
      t.belongs_to :student
    end
  end
end
