class Parent < ActiveRecord::Base
    has_secure_password
    has_many :students
    has_many :transactions, through: :students
    has_many :lessons, through: :students
    has_many :instructors, through: :lessons
    has_many :locations, through: :lessons
end