class Lesson < ActiveRecord::Base
    belongs_to :location
    has_many :lesson_students
    has_many :lesson_instructors
    has_many :students, through: :lesson_students
    has_many :instructors, through: :lesson_instructors
    has_many :parents, through: :students
end