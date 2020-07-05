class Student < ActiveRecord::Base
    belongs_to :parent
    has_many :lesson_students
    has_many :lessons, through: :lesson_students
    has_many :instructors, through: :lessons
    has_many :locations, through: :lessons
end