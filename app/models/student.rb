class Student < ActiveRecord::Base
    belongs_to :parent
    has_many :transactions
    has_many :lessons, through: :transactions
    has_many :instructors, through: :lessons
    has_many :locations, through: :lessons
end