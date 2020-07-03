class Location < ActiveRecord::Base
    has_many :lessons
    has_many :instructors, through: :lessons
    has_many :students, through: :lessons
    has_many :parents, through: :students
end