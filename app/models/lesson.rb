class Lesson < ActiveRecord::Base
    belongs_to :location
    has_many :students
    has_many :lesson_instructors
    has_many :instructors, through: :lesson_instructors
    has_many :parents, through: :students
end